import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/utils/toast_util.dart';

import 'state.dart';

class RegisterLogic extends GetxController {
  final RegisterState state = RegisterState();

  // 性别选中
  void onSexSelected(int selected) {
    state.selectedSex.value = selected;
    update(['sexSelect']);
  }

  // 性别和用户名参数检查
  bool checkSexUsername() {
    if (state.selectedSex.value == Constants.unSex) {
      ToastUtil.errorToast("sexChooseLabel".tr);
      return false;
    }

    if (state.usernameController.text.isEmpty) {
      ToastUtil.errorToast("usernameInputLabel".tr);
      return false;
    }

    return true;
  }

  // 密码和手机号参数检查
  bool checkPasswordPhone() {
    if (state.passwordController.text.isEmpty) {
      ToastUtil.errorToast("passwordInputLabel".tr);
      return false;
    }

    if (state.phoneController.text.isEmpty) {
      ToastUtil.errorToast("phoneInputLabel".tr);
      return false;
    }

    return true;
  }

  // 注册操作处理
  Future<bool> register() async {
    if (checkPasswordPhone()) {
      state.user.username = state.usernameController.text;
      state.user.password = state.passwordController.text;
      bool res = await state.userService.register(state.user);
      if (!res) {
        ToastUtil.errorToast("usernameExisted".tr);
        state.registerSort.value = 1;
        return false;
      }
      return true;
    }
    return false;
  }

  // 点击下一步
  void nextStep() async {
    if (state.registerSort.value == 1) {
      if (checkSexUsername()) {
        state.user.sex = state.selectedSex.value.toString();
        state.user.username = state.usernameController.text;
        state.registerSort.value = 2;
      }
    } else if (state.registerSort.value == 2) {
      bool res = await register();
      if (res) {
        ToastUtil.successToast("registerSuccess".tr);
        Get.back();
      }
    }
  }

  // 点击上一步
  void preStep() {
    if (state.registerSort.value == 1) {
      Get.back();
    } else if (state.registerSort.value == 2) {
      state.registerSort.value = 1;
    }
  }
}
