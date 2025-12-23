import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_response.dart';

/// A generic base class for creating API services with built-in error handling.
abstract class GenericApiService {
  final Dio _dio = ApiClient.instance;

  /// Performs a GET request.
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? 'Unknown error occurred');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// Performs a POST request.
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? 'Unknown error occurred');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// Performs a PUT request.
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? 'Unknown error occurred');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  /// Performs a DELETE request.
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } on DioException catch (e) {
      return ApiResponse.error(e.message ?? 'Unknown error occurred');
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
