import 'package:dio/dio.dart';
import '../network/connectivity_service.dart';
import 'api_response.dart';
import 'api_client.dart';

class NetworkHandler {
  final Dio _dio = ApiClient.instance;

  Future<ApiResponse> get(String url) async {
    if (!ConnectivityService.isConnected) {
      return ApiResponse.error('No internet connection');
    }

    try {
      final res = await _dio.get(url);
      return ApiResponse.success(res.data, status: res.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> post(String url, {dynamic data}) async {
    if (!ConnectivityService.isConnected) {
      return ApiResponse.error('No internet connection');
    }

    try {
      final res = await _dio.post(url, data: data);
      return ApiResponse.success(res.data, status: res.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> put(String url, {dynamic data}) async {
    if (!ConnectivityService.isConnected) {
      return ApiResponse.error('No internet connection');
    }

    try {
      final res = await _dio.put(url, data: data);
      return ApiResponse.success(res.data, status: res.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> delete(String url) async {
    if (!ConnectivityService.isConnected) {
      return ApiResponse.error('No internet connection');
    }

    try {
      final res = await _dio.delete(url);
      return ApiResponse.success(res.data, status: res.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
