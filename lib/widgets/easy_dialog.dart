import 'package:flutter/material.dart';
import 'dialogs.dart';

/// A utility class for showing adaptive dialogs.
class EasyDialog {
  /// Shows an adaptive confirmation dialog.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmText,
    VoidCallback? onConfirm,
  }) async {
    await showAdaptiveDialogBox(
      context,
      title: title,
      message: message,
      okText: confirmText ?? 'OK',
    );
    if (onConfirm != null) {
      onConfirm();
    }
  }
}
