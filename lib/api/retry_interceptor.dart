import 'dart:async';
import 'package:dio/dio.dart';

/// An interceptor that automatically retries failed requests based on custom logic.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryInterval;

  /// Creates a retry interceptor.
  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryInterval = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    var retries = err.requestOptions.extra['retries'] ?? 0;

    if (retries < maxRetries && _shouldRetry(err)) {
      retries++;
      err.requestOptions.extra['retries'] = retries;

      await Future.delayed(retryInterval);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return super.onError(e, handler);
      }
    }

    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.type == DioExceptionType.badResponse &&
            (err.response?.statusCode == 502 ||
                err.response?.statusCode == 503 ||
                err.response?.statusCode == 504));
  }
}
