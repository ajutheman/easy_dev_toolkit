import 'package:easy_dev_toolkit/core/responsive_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import '../../core/responsive_extensions.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;
  final EdgeInsetsGeometry? padding;

  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
    this.padding,
  });

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
