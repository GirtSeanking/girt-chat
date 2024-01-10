import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/common/utils/toast_util.dart';

import 'state.dart';

class NewFriendSearchLogic extends GetxController {
  final NewFriendSearchState state = NewFriendSearchState();

  void searchUser() async {
    if (ObjectUtil.stringIsNotBlank(state.searchController.text)) {
      state.searchLoading.value = true;
      String username = state.searchController.text;
      List<UserVo> res = await state.userService.searchUserInfo(username);
      state.searchResult.clear();
      state.searchLoading.value = false;
      if (res.isNotEmpty) {
        state.searchResult.addAll(res);
      } else {
        state.searchEmpty.value = true;
      }
    }
  }

  // 好友申请
  void friendApply(UserVo user) async {
    state.userApply = user;
    UserVo? current = await state.userService.getCurrentUser();
    if (current != null) {
      state.applyWordingController.text = Constants.defaultApplyMsg + current.nickName!;
    }
    Get.toNamed(RouteName.androidFriendApply);
  }

  // 发送好友申请
  void sendFriendApply() async {
    bool res = await state.friendShipService.sendFriendApply(state.userApply.username!, state.remarkController.text, state.applyWordingController.text);
    if (res) {
      ToastUtil.successToast("好友申请发送成功");
      Get.back();
    }
  }
}
