import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? mediaQueryData;
  static double? screenHeight;
  static double? screenWidth;
  static Orientation? orientation;

  init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
    orientation = mediaQueryData!.orientation;
  }
}


double getProportionalHeight(double value) {
  return (value / 812) * SizeConfig.screenHeight!;
}

double getProportionalWidth(double value){
  return (value / 375) * SizeConfig.screenWidth!;
}