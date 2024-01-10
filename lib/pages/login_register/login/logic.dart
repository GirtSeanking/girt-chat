import 'dart:io';

import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/utils/toast_util.dart';
import 'package:window_manager/window_manager.dart';

import 'state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();

  @override
  void onInit() {
    if (Platform.isWindows) {
      windowManager.setMaximumSize(windowInitialSize);
    }
    super.onInit();
  }

  void handleLogin() async {
    if (checkLoginForm()) {
      UserVo user = UserVo(username: state.usernameController.text, password: state.passwordController.text);
      bool res = await state.userService.loginStorage(user);
      if (res) {
        bool res2 = await state.userService.loginIM(user);
        if (res2) {
          ToastUtil.successToast("loginSuccess".tr);
          if (GetPlatform.isAndroid) {
            Get.offAndToNamed(RouteName.androidHome);
          } else if (GetPlatform.isWindows) {
            Get.offAndToNamed(RouteName.windowsMain);
          }
        } else {
          ToastUtil.errorToast("消息服务登录失败");
        }
      } else {
        ToastUtil.errorToast("loginFormError".tr);
      }

    }
  }

  // 检查表单是否为空
  bool checkLoginForm() {
    if (state.usernameController.text.isEmpty) {
      ToastUtil.errorToast("usernameNullError".tr);
      return false;
    }

    if (state.passwordController.text.isEmpty) {
      ToastUtil.errorToast("passwordNullError".tr);
      return false;
    }

    return true;
  }

}
