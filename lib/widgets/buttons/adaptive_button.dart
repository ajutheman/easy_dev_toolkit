// import 'package:easy_dev_toolkit/core/responsive_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/responsive_extensions.dart';

/// A button that adapts its style based on the target platform (Material for Android/others, Cupertino for iOS/macOS).
class AdaptiveButton extends StatelessWidget {
  /// The label text for the button.
  final String text;

  /// The callback that is called when the button is tapped or otherwise activated.
  final VoidCallback onPressed;

  /// Whether the button should be filled with the primary color or transparent.
  final bool filled;

  /// Optional padding around the button content.
  final EdgeInsetsGeometry? padding;

  /// Creates an adaptive button.
  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
    this.padding,
  });

  /// Creates a filled adaptive button.
  const AdaptiveButton.filled({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
  }) : filled = true;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final content = Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
    );

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return CupertinoButton(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        color: filled ? Theme.of(context).colorScheme.primary : null,
        onPressed: onPressed,
        child: content,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
      child: content,
    );
  }
}
