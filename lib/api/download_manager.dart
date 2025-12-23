// lib/api/download_manager.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

typedef ProgressCallback = void Function(int received, int total);

class DownloadManager {
  final Dio _dio = Dio();

  Future<File> _localFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$filename');
  }

  /// Download file to documents, reports progress. If file exists, will try to resume.
  Future<File> download(String url, String filename,
      {ProgressCallback? onProgress}) async {
    final file = await _localFile(filename);
    int downloadedBytes = 0;
    if (await file.exists()) {
      downloadedBytes = await file.length();
    }

    final headers = <String, String>{};
    if (downloadedBytes > 0) {
      headers['range'] = 'bytes=$downloadedBytes-';
    }

    final response = await _dio.get<ResponseBody>(
      url,
      options: Options(
        responseType: ResponseType.stream,
        headers: headers,
      ),
    );

    final total = response.headers.value('content-length') != null
        ? int.parse(response.headers.value('content-length')!) + downloadedBytes
        : -1;

    final raf = file.openSync(mode: FileMode.append);
    final stream = response.data!.stream;
    int received = downloadedBytes;

    await for (final chunk in stream) {
      raf.writeFromSync(chunk);
      received += chunk.length;
      if (onProgress != null && total > 0) onProgress(received, total);
    }
    await raf.close();

    return file;
  }
}
