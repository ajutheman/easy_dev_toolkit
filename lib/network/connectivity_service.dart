// lib/network/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  static bool isConnected = true;

  static Stream<bool> get statusStream => _controller.stream;

  static Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    isConnected = !result.contains(ConnectivityResult.none);
    _controller.add(isConnected);

    _connectivity.onConnectivityChanged.listen((results) {
      isConnected = !results.contains(ConnectivityResult.none);
      _controller.add(isConnected);
    });
  }

  static void dispose() {
    _controller.close();
  }
}
