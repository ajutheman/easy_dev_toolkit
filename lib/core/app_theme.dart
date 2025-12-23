import 'package:flutter/material.dart';

class EasyTheme extends ChangeNotifier {
  static final EasyTheme instance = EasyTheme._();
  EasyTheme._();

  ThemeMode _mode = ThemeMode.light;

  /// Current theme mode (light, dark, or system)
  static ThemeMode get mode => instance._mode;

  /// Toggle between light and dark modes
  static void toggle() {
    instance._mode =
        instance._mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    instance.notifyListeners();
  }

  /// Explicitly set the theme mode
  static void set(ThemeMode mode) {
    instance._mode = mode;
    instance.notifyListeners();
  }

  static ThemeData light({Color primary = const Color(0xFF2196F3)}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      useMaterial3: true,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  static ThemeData dark({Color primary = const Color(0xFF2196F3)}) {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ),
      textTheme: base.textTheme.copyWith(
        bodyMedium: const TextStyle(fontSize: 14),
        bodyLarge: const TextStyle(fontSize: 16),
        titleLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  /// AMOLED theme variant
  static ThemeData amoled() {
    return dark(primary: Colors.blue).copyWith(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
        surface: Colors.black,
      ),
    );
  }
}
