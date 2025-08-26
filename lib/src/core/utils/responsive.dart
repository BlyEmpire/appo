import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);

    if (Responsive.isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (Responsive.isTablet(context)) return tablet ?? mobile;
    return mobile;
  }
}

class Responsive {
  /// statice screen size
  static late double screenWidth;
  static late double screenHeight;

  /// Device Type
  static late DeviceType deviceType;

  /// initializae the context
  static void init({required BuildContext context}) {
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;

    if (screenWidth > 1200) {
      deviceType = DeviceType.desktop;
    } else if (screenWidth >= 600) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }
  }

  /// Static helpers
  static bool isMobile(BuildContext context) => screenWidth < 600;
  static bool isTablet(BuildContext context) =>
      screenWidth >= 600 && screenWidth < 1200;
  static bool isDesktop(BuildContext context) => screenWidth >= 1200;

  /// Responsive width based on width
  static double wp(double percent) => screenWidth * percent / 100;

  /// Responsive height based on width
  static double hp(double percent) => screenWidth * percent / 100;

  /// Responsive font size (scales with width)
  static double sp(double size) => wp(size);
}
