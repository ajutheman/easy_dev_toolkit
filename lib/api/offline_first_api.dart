// lib/api/offline_first_api.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import '../network/connectivity_service.dart';
import '../storage/cache_manager.dart';
import 'api_client.dart';
import 'api_response.dart';

class OfflineFirstApi {
  final Dio _dio = ApiClient.instance;
  final Duration defaultCacheTtl;

  OfflineFirstApi({this.defaultCacheTtl = const Duration(minutes: 10)});

  String _key(String method, String url, [dynamic body]) {
    final b = body == null ? '' : json.encode(body);
    return '${method.toUpperCase()}::$url::$b';
  }

  Future<ApiResponse> get(String url,
      {bool useCache = true, Duration? ttl}) async {
    final key = _key('GET', url);
    if (!ConnectivityService.isConnected) {
      if (useCache) {
        final cached = await CacheManager.getJson(key);
        if (cached != null) return ApiResponse.success(cached);
        return ApiResponse.error('No connection and no cache');
      }
      return ApiResponse.error('No connection');
    }

    try {
      final res = await _dio.get(url);
      final data = res.data;
      if (useCache) {
        await CacheManager.putJson(key, data, ttl: ttl ?? defaultCacheTtl);
      }
      return ApiResponse.success(data, status: res.statusCode);
    } catch (e) {
      // fallback to cache on error
      if (useCache) {
        final cached = await CacheManager.getJson(key);
        if (cached != null) return ApiResponse.success(cached);
      }
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> post(String url,
      {dynamic body, bool useCache = false, Duration? ttl}) async {
    final key = _key('POST', url, body);
    if (!ConnectivityService.isConnected) {
      if (useCache) {
        final cached = await CacheManager.getJson(key);
        if (cached != null) return ApiResponse.success(cached);
        return ApiResponse.error('No connection and no cache');
      }
      return ApiResponse.error('No connection');
    }

    try {
      final res = await _dio.post(url, data: body);
      final data = res.data;
      if (useCache) {
        await CacheManager.putJson(key, data, ttl: ttl ?? defaultCacheTtl);
      }
      return ApiResponse.success(data, status: res.statusCode);
    } catch (e) {
      if (useCache) {
        final cached = await CacheManager.getJson(key);
        if (cached != null) return ApiResponse.success(cached);
      }
      return ApiResponse.error(e.toString());
    }
  }
}
