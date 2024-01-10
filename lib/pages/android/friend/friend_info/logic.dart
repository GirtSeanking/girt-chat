import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/common/utils/toast_util.dart';
import 'package:girt_chat/pages/android/friend/friend_info/widgets/dialog/set_remark.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/login_register/login/logic.dart';
import 'package:girt_chat/pages/public/avatar.dart';

import 'state.dart';

class FriendInfoLogic extends GetxController {
  final FriendInfoState state = FriendInfoState();

  @override
  void onReady() {
    initUserInfo();
    super.onReady();
  }

  void initUserInfo() async {
    if (Get.arguments is UserFriend) {
      state.currentUserFriend.value = Get.arguments;
    }

    if (ObjectUtil.stringIsNotBlank(state.currentUserFriend.value.username)) {
      UserVo res = await state.userService
          .getUserInfoByUsername(state.currentUserFriend.value.username!);
      if (ObjectUtil.stringIsNotBlank(res.username)) {
        state.currentUserFriend.value.fillInBaseUserInfo(res);
      }
    }
    state.userInfoLoading.value = false;
    update(['userInfo']);
  }

  void setRemark(String value) async {
    if (ObjectUtil.stringIsNotBlank(value)) {
      bool res = await state.friendShipService.setRemark(value, state.currentUserFriend.value);
      if (res) {
        state.currentUserFriend.value.friendRemark = value;
        update(['userInfo']);
        ToastUtil.successAnimated();
      } else {
        ToastUtil.errorToast("修改备注失败");
      }
    }
  }

  void handleMenuSelected(String value, BuildContext context) {
    if (value == "setRemark") {
      openSetRemarkDialog(context);
    }
  }

  void openSetRemarkDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return SetRemarkDialog(
            onFinished: setRemark,
            hintText: ObjectUtil.stringIsNotBlank(
                    state.currentUserFriend.value.nickName)
                ? state.currentUserFriend.value.nickName!
                : state.currentUserFriend.value.username ?? "",
            text: state.currentUserFriend.value.friendRemark ?? "",
          );
        });
  }

  void jumpToChatPage() {
    ConversationEntity conversationEntity = ConversationEntity.fromUserFriend(state.currentUserFriend.value);
    Get.toNamed(RouteName.androidChatPage, arguments: conversationEntity);
  }
}
