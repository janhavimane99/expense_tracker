import 'package:flutter/material.dart';

class ScreenUtil {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

 /* static double getResponsiveWidth(BuildContext context) {
    late double responsiveWidth;

    if (getWidth(context) > 1500) {
      responsiveWidth = getWidth(context) * 0.4;
    } else if (getWidth(context) > 1200) {
      responsiveWidth = getWidth(context) * 0.5;
    } else if (getWidth(context) > 1000) {
      responsiveWidth = getWidth(context) * 0.6;
    } else if (getWidth(context) > 800) {
      responsiveWidth = getWidth(context) * 0.7;
    } else if (getWidth(context) > 600) {
      responsiveWidth = getWidth(context) * 0.8;
    } else {
      responsiveWidth = getWidth(context) * 1;
    }

    return responsiveWidth;
  }*/

  static double getResponsiveWidth(BuildContext context, {double? percentage}) {
    if (percentage != null) {
      // If a percentage is provided, use it to calculate the width
      return getWidth(context) * percentage;
    } else {
      // Default behavior when percentage is not provided
      late double responsiveWidth;

      if (getWidth(context) > 1500) {
        responsiveWidth = getWidth(context) * 0.4;
      } else if (getWidth(context) > 1200) {
        responsiveWidth = getWidth(context) * 0.5;
      } else if (getWidth(context) > 1000) {
        responsiveWidth = getWidth(context) * 0.6;
      } else if (getWidth(context) > 800) {
        responsiveWidth = getWidth(context) * 0.7;
      } else if (getWidth(context) > 600) {
        responsiveWidth = getWidth(context) * 0.8;
      } else {
        responsiveWidth = getWidth(context) * 1;
      }

      return responsiveWidth;
    }
  }


  static double getResponsiveHeight(BuildContext context, double percentage) {
    return getHeight(context) * percentage;
  }
}
