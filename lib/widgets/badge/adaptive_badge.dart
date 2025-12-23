import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A badge widget that adapts its style based on the target platform.
class AdaptiveBadge extends StatelessWidget {
  /// The label to display inside the badge.
  final String label;

  /// The background color of the badge.
  final Color? backgroundColor;

  /// The text color of the badge.
  final Color? textColor;

  /// Creates an adaptive badge.
  const AdaptiveBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: backgroundColor ?? CupertinoColors.activeBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor ?? CupertinoColors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Badge(
      label: Text(label),
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
