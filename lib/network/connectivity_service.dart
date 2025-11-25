import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService._();

  static final Connectivity _connectivity = Connectivity();
  static final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  static Stream<bool> get statusStream => _controller.stream;

  static Future<void> initialize() async {
    final result = await _connectivity.checkConnectivity();
    _controller.add(result != ConnectivityResult.none);

    _connectivity.onConnectivityChanged.listen((result) {
      _controller.add(result != ConnectivityResult.none);
    });
  }

  static void dispose() {
    _controller.close();
  }
}
