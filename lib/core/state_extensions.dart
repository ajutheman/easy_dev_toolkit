import 'package:flutter/material.dart';

/// Extensions for [State] to add safety features.
extension StateExtensions on State {
  /// Calls [setState] only if the widget is currently mounted.
  /// 
  /// This prevents "setState() called after dispose()" errors.
  void setStateSafe(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}
