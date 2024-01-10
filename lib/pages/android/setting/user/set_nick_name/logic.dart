import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/utils/toast_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:material_dialogs/dialogs.dart';

import 'state.dart';

class SetNickNameLogic extends GetxController {
  final SetNickNameState state = SetNickNameState();

  @override
  void onReady() {
    initNickName();
    super.onReady();
  }

  void initNickName() {
    HomeLogic homeLogic = Get.find();
    state.oldNickName = homeLogic.state.user.value.nickName ?? "";
    state.newNickName = homeLogic.state.user.value.nickName ?? "";
    state.inputController.text = state.oldNickName;
    state.textLength.value = state.oldNickName.length;
    if (state.oldNickName.isEmpty) {
      state.hintText.value = homeLogic.state.user.value.username ?? "";
    }
  }

  void inputChanged(String value) {
    state.newNickName = value;
    state.textLength.value = state.newNickName.length;
  }

  void saveNewNickName() async {
    ToastUtil.loading();
    var homeState = Get.find<HomeLogic>().state;
    UserVo userVo = homeState.user.value;
    userVo.nickName = state.newNickName;
    await state.userService.saveNewNickName(userVo);
    ToastUtil.dismiss();
    Get.back();
  }

  back(BuildContext context) {
    if (state.oldNickName != state.newNickName) {
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
              saveNewNickName();
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
