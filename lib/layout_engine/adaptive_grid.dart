import 'package:flutter/material.dart';
import '../core/breakpoints.dart';
import '../core/responsive_extensions.dart';

class AdaptiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const AdaptiveGrid({super.key, required this.children, this.spacing = 12});

  int _columns() {
    if (BreakPoints.isDesktop) return 4;
    if (BreakPoints.isTablet) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final col = _columns();

    return GridView.count(
      crossAxisCount: col,
      padding: EdgeInsets.all(12.w),
      mainAxisSpacing: spacing.h,
      crossAxisSpacing: spacing.w,
      childAspectRatio: BreakPoints.isPhone ? 0.8 : 1.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
