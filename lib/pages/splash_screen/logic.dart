import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/service/service_initialize.dart';
import 'package:girt_chat/common/utils/toast_util.dart';

import 'state.dart';

class SplashScreenLogic extends GetxController {
  final SplashScreenState state = SplashScreenState();

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  initialize() async {
    await serviceInit().then(
      (value) {
        if (GetPlatform.isAndroid) {
          // FlutterNativeSplash.remove();
          // Get.offAndToNamed(RouteName.login);
          androidAutoLogin();
        } else if (GetPlatform.isWindows) {
          windowsUserInit();
        }
      },
    );
  }

  androidAutoLogin() async {
    Timer myTimer = Timer(const Duration(seconds: 3), () {
      ToastUtil.errorToast("登录失效，请重新登录");
      FlutterNativeSplash.remove();
      Get.offAndToNamed(RouteName.login);
    });
    UserVo? user = await state.userService.getLocalIsLoginUser();
    if (user != null) {
      bool res = await state.userService.loginStorage(
          UserVo(username: user.username, password: user.password));
      if (res) {
        bool res2 = await state.userService.loginIM(user);
        if (res2) {
          myTimer.cancel();
          FlutterNativeSplash.remove();
          Get.offAndToNamed(RouteName.androidHome);
        } else {
          ToastUtil.errorToast("消息服务登录失败");
        }
      } else {
        ToastUtil.errorToast("loginFormError".tr);
      }
    } else {
      myTimer.cancel();
      FlutterNativeSplash.remove();
      Get.offAndToNamed(RouteName.login);
    }
  }

  void windowsUserInit() async {
    UserVo? user = await state.userService.getLocalIsLoginUser();
    if (user == null) {
      Get.offNamed(RouteName.login);
    } else {
      state.user.value = user;
    }
  }

  void windowsLogin() async {
    ToastUtil.loading();
    bool res = await state.userService.loginStorage(UserVo(
        username: state.user.value.username,
        password: state.user.value.password));
    ToastUtil.dismiss();
    if (res) {
      Get.offAndToNamed(RouteName.windowsMain);
    } else {
      ToastUtil.errorToast("登录失败，请输入账号和密码");
      Get.offAndToNamed(RouteName.login);
    }
  }
}
