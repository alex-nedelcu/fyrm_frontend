import 'package:flutter/material.dart';
import 'package:fyrm_frontend/helper/constants.dart';

class SizeConfiguration {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfiguration.screenHeight;
  return (inputHeight / kUniversalLayoutHeight) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfiguration.screenWidth;
  return (inputWidth / kUniversalLayoutWidth) * screenWidth;
}
