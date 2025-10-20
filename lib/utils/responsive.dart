import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static bool isMobile(BuildContext context) => width(context) < 650;
  static bool isTablet(BuildContext context) => width(context) >= 650 && width(context) < 1100;
  static bool isDesktop(BuildContext context) => width(context) >= 1100;
  
  // Responsive font sizes
  static double fontSize(BuildContext context, double size) {
    if (isMobile(context)) return size;
    if (isTablet(context)) return size * 1.1;
    return size * 1.2;
  }
  
  // Responsive padding
  static double padding(BuildContext context, double size) {
    if (isMobile(context)) return size;
    if (isTablet(context)) return size * 1.2;
    return size * 1.5;
  }
  
  // Responsive spacing
  static double spacing(BuildContext context, double size) {
    if (isMobile(context)) return size;
    if (isTablet(context)) return size * 1.1;
    return size * 1.3;
  }
  
  // Get responsive value
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }
  
  // Max width for content
  static double maxWidth(BuildContext context) {
    return responsive(
      context,
      mobile: width(context),
      tablet: 800,
      desktop: 1200,
    );
  }
}