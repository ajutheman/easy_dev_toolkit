import 'package:flutter/material.dart';

/// Standardized border radius tokens for the design system.
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double circular = 999.0;

  static BorderRadius get roundedXs => BorderRadius.circular(xs);
  static BorderRadius get roundedSm => BorderRadius.circular(sm);
  static BorderRadius get roundedMd => BorderRadius.circular(md);
  static BorderRadius get roundedLg => BorderRadius.circular(lg);
  static BorderRadius get roundedXl => BorderRadius.circular(xl);
  static BorderRadius get roundedCircular => BorderRadius.circular(circular);
}

/// Standardized spacing tokens for consistent margins and gaps.
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const SizedBox gutterXs = SizedBox(width: xs, height: xs);
  static const SizedBox gutterSm = SizedBox(width: sm, height: sm);
  static const SizedBox gutterMd = SizedBox(width: md, height: md);
  static const SizedBox gutterLg = SizedBox(width: lg, height: lg);
  static const SizedBox gutterXl = SizedBox(width: xl, height: xl);
}

/// Standardized animation duration tokens.
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
}
