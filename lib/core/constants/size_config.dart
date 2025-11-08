import 'package:flutter/material.dart';

double screenHeight(BuildContext context) => MediaQuery.sizeOf(context).height;

double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;

double paddingWidth(BuildContext context, double value) {
  return value * (screenWidth(context) / 375);
}

double paddingAll(BuildContext context, double value) {
  return value * (screenWidth(context) / 375);
}

double paddingHorizontal(BuildContext context, double value) {
  return value * (screenWidth(context) / 375);
}

double paddingVertical(BuildContext context, double value) {
  return value * (screenHeight(context) / 812);
}

double paddingTop(BuildContext context, double value) {
  return value * (screenHeight(context) / 812);
}

double paddingBottom(BuildContext context, double value) {
  return value * (screenHeight(context) / 812);
}

double paddingLeft(BuildContext context, double value) {
  return value * (screenWidth(context) / 375);
}

double paddingRight(BuildContext context, double value) {
  return value * (screenWidth(context) / 375);
}

double getAppBarHeight(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 360) {
    return width * 0.95; // موبايلات صغيرة جدًا زي iPhone SE
  } else if (width < 400) {
    return width * 1.0; // متوسطة (زي iPhone 11)
  } else {
    return width * 1.1; // كبيرة (زي Pro Max أو Android كبير)
  }
}
