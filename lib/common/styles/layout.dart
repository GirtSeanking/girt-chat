import 'package:flutter/material.dart';
import 'package:get/get.dart';

const windowInitialSize = Size(550, 600);
const windowMaxSize8K = Size(7680.0, 4320.0);

double getScreenHeight() {
  return Get.height;
}

double getScreenWidth() {
  return Get.width;
}

double getHeight(double pixels) {
  double x = getScreenHeight() / pixels;
  return getScreenHeight() / x;
}

double getWidth(double pixels) {
  double x = getScreenWidth() / pixels;
  return getScreenWidth() / x;
}

double getWidthByRatio(double ratio) {
  return getWidth(getScreenWidth() * ratio);
}

double getHeightByRatio(double ratio) {
  return getHeight(getScreenHeight() * ratio);
}