// lib/api/upload_service.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_response.dart';

typedef ProgressCallback = void Function(int sentBytes, int totalBytes);

class UploadService {
  final Dio _dio = ApiClient.instance;

  Future<ApiResponse> uploadFile({
    required String endpoint,
    required File file,
    String fieldName = 'file',
    Map<String, dynamic>? extraFields,
    ProgressCallback? onProgress,
    Map<String, String>? headers,
  }) async {
    try {
      final form = FormData();
      form.files.add(MapEntry(
        fieldName,
        await MultipartFile.fromFile(file.path,
            filename: file.uri.pathSegments.last),
      ));
      if (extraFields != null) {
        extraFields
            .forEach((k, v) => form.fields.add(MapEntry(k, v.toString())));
      }

      final res = await _dio.post(
        endpoint,
        data: form,
        options: Options(headers: headers),
        onSendProgress: (sent, total) {
          if (onProgress != null) onProgress(sent, total);
        },
      );
      return ApiResponse.success(res.data, status: res.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
