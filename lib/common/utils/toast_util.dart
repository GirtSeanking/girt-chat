import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';

/// 基础提示组件（包括加载、信息提示、错误提示、成功提示、警告提示）
class ToastUtil {
  static void primary(String msg,
      {milliseconds = 2000, snackPosition = SnackPosition.TOP}) {
    _toLog(msg);
    Get.snackbar("公告", msg,
        colorText: AppColors.colorPrimaryText,
        backgroundColor: AppColors.colorPrimaryBackground,
        icon: Icon(Icons.fiber_new, color: AppColors.colorPrimaryText),
        shouldIconPulse: true,
        duration: Duration(milliseconds: milliseconds));
  }

  static void primaryToast(String msg,
      {milliseconds = 2000, position = ToastPosition.center}) {
    _toLog(msg);
    showToast(msg,
        backgroundColor: AppColors.colorPrimaryBackground,
        textStyle: TextStyle(color: AppColors.colorPrimaryText),
        position: position,
        duration: Duration(milliseconds: milliseconds));
  }

  static void error(String msg,
      {milliseconds = 2000, snackPosition = SnackPosition.TOP}) {
    _toLog(msg, level: Level.error);
    Get.snackbar("错误", msg,
        colorText: AppColors.colorErrorText,
        backgroundColor: AppColors.colorErrorBackground,
        icon: Icon(Icons.error, color: AppColors.colorErrorText),
        shouldIconPulse: true,
        duration: Duration(milliseconds: milliseconds));
  }

  static void errorToast(String msg,
      {milliseconds = 2000, position = ToastPosition.center}) {
    _toLog(msg, level: Level.error);
    showToast(
      msg,
      backgroundColor: AppColors.colorErrorBackground,
      textStyle: TextStyle(color: AppColors.colorErrorText),
      position: position,
      duration: Duration(milliseconds: milliseconds),
    );
  }

  static void success(String msg,
      {milliseconds = 2000, snackPosition = SnackPosition.TOP}) {
    _toLog(msg);
    Get.snackbar("成功", msg,
        colorText: AppColors.colorSuccessText,
        backgroundColor: AppColors.colorSuccessBackground,
        icon: Icon(Icons.check_circle, color: AppColors.colorSuccessText),
        shouldIconPulse: true,
        duration: Duration(milliseconds: milliseconds),
        snackPosition: snackPosition);
  }

  static void successToast(String msg,
      {milliseconds = 2000, position = ToastPosition.center}) {
    _toLog(msg);
    showToast(msg,
        backgroundColor: AppColors.colorSuccessBackground,
        textStyle: TextStyle(color: AppColors.colorSuccessText),
        position: position,
        duration: Duration(milliseconds: milliseconds));
  }

  static void successAnimated(
      {milliseconds = 1300, position = ToastPosition.center}) {
    _toLog("成功动画");
    showToastWidget(
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 1,
              )
            ],
          ),
          child: Lottie.asset("assets/success/success_animated.json",
              width: 80, height: 80, repeat: false),
        ),
        position: position,
        duration: Duration(milliseconds: milliseconds));
  }

  static void info(String msg,
      {milliseconds = 2000, snackPosition = SnackPosition.TOP}) {
    _toLog(msg);
    Get.snackbar("提示", msg,
        colorText: AppColors.colorInfoText,
        backgroundColor: AppColors.colorInfoBackground,
        icon: Icon(
          Icons.info,
          color: AppColors.colorInfoText,
        ),
        shouldIconPulse: true,
        duration: Duration(milliseconds: milliseconds));
  }

  static void infoToast(String msg,
      {milliseconds = 2000, position = ToastPosition.center}) {
    _toLog(msg);
    showToast(msg,
        backgroundColor: AppColors.colorInfoBackground,
        textStyle: TextStyle(color: AppColors.colorInfoText),
        position: position,
        duration: Duration(milliseconds: milliseconds));
  }

  static void warning(String msg,
      {milliseconds = 2000, snackPosition = SnackPosition.TOP}) {
    _toLog(msg, level: Level.warning);
    Get.snackbar("警告", msg,
        colorText: AppColors.colorWarningText,
        backgroundColor: AppColors.colorWarningBackground,
        icon: Icon(
          Icons.warning,
          color: AppColors.colorWarningText,
        ),
        shouldIconPulse: true,
        duration: Duration(milliseconds: milliseconds));
  }

  static void warningToast(String msg,
      {milliseconds = 2000, position = ToastPosition.center}) {
    _toLog(msg, level: Level.warning);
    showToast(msg,
        backgroundColor: AppColors.colorWarningBackground,
        textStyle: TextStyle(color: AppColors.colorWarningText),
        position: position,
        duration: Duration(milliseconds: milliseconds));
  }

  static void loading() {
    _toLog("loading...");
    showToastWidget(
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: SpinKitFadingCircle(
              color: Colors.black,
            ),
          ),
        ),
        duration: const Duration(days: 30));
  }

  static void dismiss() {
    _toLog("loading dismiss");
    dismissAllToast();
  }

  static void _toLog(String msg, {Level level = Level.info}) {
    LogService.to
        .log(msg, toConsole: true, level: level, logType: LogType.toast);
  }
}
