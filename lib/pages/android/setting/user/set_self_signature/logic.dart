import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/utils/toast_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:material_dialogs/dialogs.dart';

import 'state.dart';

class SetSelfSignatureLogic extends GetxController {
  final SetSelfSignatureState state = SetSelfSignatureState();

  @override
  void onReady() {
    initNickName();
    super.onReady();
  }

  void initNickName() {
    HomeLogic homeLogic = Get.find();
    state.oldSelfSignature = homeLogic.state.user.value.selfSignature ?? "";
    state.newSelfSignature = homeLogic.state.user.value.selfSignature ?? "";
    state.inputController.text = state.oldSelfSignature;
    if (state.oldSelfSignature.isEmpty) {
      state.hintText.value = "介绍一下自己~";
    }
  }

  void inputChanged(String value) {
    state.newSelfSignature = value;
  }

  void saveNewSelfSignature() async {
    ToastUtil.loading();
    var homeState = Get.find<HomeLogic>().state;
    UserVo userVo = homeState.user.value;
    userVo.selfSignature = state.newSelfSignature;
    await state.userService.saveNewSelfSignature(userVo);
    ToastUtil.dismiss();
    Get.back();
  }

  back(BuildContext context) {
    if (state.oldSelfSignature != state.newSelfSignature) {
      Dialogs.materialDialog(
        context: context,
        msg: "是否保存修改",
        title: "提示",
        actions: [
          AppButton(
            text: "取消",
            onPressed: () {
              Get.back();
            },
            width: 80,
            height: 40,
          ),
          AppButton.primary(
            text: "保存",
            onPressed: () async {
              Get.back();
              saveNewSelfSignature();
            },
            width: 80,
            height: 40,
          )
        ],
      );
    } else {
      Get.back();
    }
  }

}
