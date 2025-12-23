import 'package:flutter/material.dart';
import 'breakpoints.dart';


/// Extensions for [BuildContext] to simplify common UI and navigation tasks.
extension ContextExtensions on BuildContext {
  // --- Navigation Extensions ---

  /// Simplifies [Navigator.push]
  Future<T?> push<T>(Widget page) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Simplifies [Navigator.pushReplacement]
  Future<T?> pushReplacement<T, TO>(Widget page) {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Simplifies [Navigator.pushAndRemoveUntil]
  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  /// Simplifies [Navigator.pop]
  void pop<T>([T? result]) => Navigator.pop<T>(this, result);

  // --- Theme Extensions ---

  /// Access the current [ThemeData] quickly
  ThemeData get theme => Theme.of(this);

  /// Access the current [TextTheme] quickly
  TextTheme get textTheme => theme.textTheme;

  /// Access the current [ColorScheme] quickly
  ColorScheme get colorScheme => theme.colorScheme;

  /// Check if the current theme is dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // --- MediaQuery Extensions ---

  /// Access current screen width
  double get width => MediaQuery.of(this).size.width;

  /// Access current screen height
  double get height => MediaQuery.of(this).size.height;

  /// Access current screen orientation
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Check if the screen is in landscape mode
  bool get isLandscape => orientation == Orientation.landscape;

  /// Access current padding (e.g., safe area)
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// Access current viewInsets (e.g., keyboard height)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Access safe height (excluding top and bottom safe area paddings)
  double get safeHeight => height - mediaQueryPadding.vertical;

  /// Access safe width (excluding left and right safe area paddings)
  double get safeWidth => width - mediaQueryPadding.horizontal;

  /// Access current keyboard height
  double get keyboardHeight => viewInsets.bottom;

  /// Check if the screen width corresponds to a tablet
  bool get isTablet => width >= Breakpoints.tablet && width < Breakpoints.desktop;

  /// Check if the screen width corresponds to a desktop
  bool get isDesktop => width >= Breakpoints.desktop;

  /// Hides the soft keyboard
  void hideKeyboard() => FocusScope.of(this).unfocus();

  // --- Notification/Snackbar Extensions ---

  /// Show a snackbar quickly
  void showSnackBar(String message, {Duration duration = const Duration(seconds: 2)}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}
