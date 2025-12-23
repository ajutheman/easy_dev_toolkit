import 'package:dio/dio.dart';
import 'token_manager.dart';
import 'api_config.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await TokenManager.access;

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }

  bool _isTokenExpired(DioException err) {
    return err.response?.statusCode == 401;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_isTokenExpired(err)) {
      final refresh = await TokenManager.refresh;
      if (refresh != null) {
        try {
          final dio = Dio();
          final response = await dio.post(
            // ApiConfig.refreshTokenEndpoint,
            ApiConfig.baseUrl,
            data: {"refresh_token": refresh},
          );

          final newToken = response.data["access_token"];
          final newRefresh = response.data["refresh_token"];

          await TokenManager.saveTokens(
            access: newToken,
            refresh: newRefresh,
          );

          // Retry original request
          final newReq = err.requestOptions
              .copyWith(headers: {"Authorization": "Bearer $newToken"});

          final retryResponse = await dio.fetch(newReq);
          return handler.resolve(retryResponse);
        } catch (e) {
          await TokenManager.clear();
        }
      }
    }

    super.onError(err, handler);
  }
}
