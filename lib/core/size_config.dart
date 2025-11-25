import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double _scaleWidth;
  static late double _scaleHeight;
  static late double _scaleText;
  static bool _initialized = false;

  static void init(
    BuildContext context, {
    double baseWidth = 375,
    double baseHeight = 812,
  }) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    _scaleWidth = screenWidth / baseWidth;
    _scaleHeight = screenHeight / baseHeight;
    _scaleText = _scaleWidth;

    _initialized = true;
  }

  static void _ensureInit() {
    if (!_initialized) {
      throw FlutterError(
        'SizeConfig.init(context) must be called before using .w, .h, .sp.',
      );
    }
  }

  static double w(double width) {
    _ensureInit();
    return width * _scaleWidth;
  }

  static double h(double height) {
    _ensureInit();
    return height * _scaleHeight;
  }

  static double sp(double fontSize) {
    _ensureInit();
    return fontSize * _scaleText;
  }
}
