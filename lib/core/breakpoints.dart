import 'size_config.dart';

class BreakPoints {
  static bool get isPhone => SizeConfig.screenWidth < 600;
  static bool get isTablet =>
      SizeConfig.screenWidth >= 600 && SizeConfig.screenWidth < 1024;
  static bool get isDesktop => SizeConfig.screenWidth >= 1024;
}
