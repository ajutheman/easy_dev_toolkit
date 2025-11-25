import 'package:flutter/material.dart';
import '../design_system/radius.dart';
import '../design_system/shadows.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool useShadow;
  final Color? color;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.useShadow = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(RadiusToken.medium),
        boxShadow: useShadow ? Shadows.soft : null,
      ),
      child: child,
    );
  }
}
