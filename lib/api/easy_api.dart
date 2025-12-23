import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_response.dart';
import 'retry_interceptor.dart';
import '../storage/cache_manager.dart';
import '../network/connectivity_service.dart';

/// A high-level static wrapper for comprehensive networking.
/// 
/// EasyApi integrates caching, retries, and clean response mapping.
class EasyApi {
  static final Dio _dio = ApiClient.instance;
  static bool _initialized = false;

  /// Initializes EasyApi with custom settings.
  static void init({
    String? baseUrl,
    List<Interceptor>? interceptors,
    int maxRetries = 3,
  }) {
    if (baseUrl != null) _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(RetryInterceptor(dio: _dio, maxRetries: maxRetries));
    if (interceptors != null) _dio.interceptors.addAll(interceptors);
    _initialized = true;
  }

  static void _ensureInitialized() {
    if (!_initialized) init();
  }

  /// Performs a GET request with optional caching.
  static Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool useCache = true,
    Duration? ttl,
    T Function(dynamic)? fromJson,
  }) async {
    _ensureInitialized();
    final cacheKey = 'GET::$path::$queryParameters';

    if (!ConnectivityService.isConnected && useCache) {
      final cached = await CacheManager.getJson(cacheKey);
      if (cached != null) {
        return ApiResponse.success(
          fromJson != null ? fromJson(cached) : cached as T,
        );
      }
    }

    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      if (useCache) {
        await CacheManager.putJson(
          cacheKey,
          response.data,
          ttl: ttl ?? const Duration(minutes: 10),
        );
      }
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } catch (e) {
      if (useCache) {
        final cached = await CacheManager.getJson(cacheKey);
        if (cached != null) {
          return ApiResponse.success(
            fromJson != null ? fromJson(cached) : cached as T,
          );
        }
      }
      return ApiResponse.error(e.toString());
    }
  }

  /// Performs a POST request.
  static Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    T Function(dynamic)? fromJson,
  }) async {
    _ensureInitialized();
    try {
      final response = await _dio.post(path, data: data);
      return ApiResponse.success(
        fromJson != null ? fromJson(response.data) : response.data as T,
        status: response.statusCode,
      );
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
