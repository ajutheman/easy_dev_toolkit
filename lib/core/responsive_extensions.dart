import 'package:flutter/widgets.dart';
import 'size_config.dart';

extension SizeNumExtensions on num {
  double get w => SizeConfig.w(toDouble());
  double get h => SizeConfig.h(toDouble());
  double get sp => SizeConfig.sp(toDouble());
}

extension WidgetExtensions on Widget {
  Widget paddingAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: this,
      );

  Widget center() => Center(child: this);

  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();
}
