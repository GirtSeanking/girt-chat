import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/common/utils/toast_util.dart';

import 'state.dart';

class ChatLogic extends GetxController {
  final ChatState state = ChatState();

  @override
  void onReady() {
    initMessages();
    messageListScrollListener();
    super.onReady();
  }

  // 初始化消息列表
  void initMessages() async {
    List<MessageEntity> res = await state.messageService.getHistoryMessage(null, state.currentConversation.value.userID!);
    state.historyMessage.addAll(res);
    setMessageRead();
  }

  // 加载更多消息列表
  void loadMoreMessage() async {
    List<MessageEntity> res = await state.messageService.getHistoryMessage(state.historyMessage.last.msgID, state.currentConversation.value.userID!);
    state.historyMessage.addAll(res);
  }

  void setMessageRead() {
    state.messageService.setMessageListRead(state.currentConversation.value.userID!);
  }

  void receiveMsg(MessageEntity message) {
    if(message.sender == state.currentConversation.value.userID) {
      state.historyMessage.insert(0, message);
      setMessageRead();
    }
  }

  void sendMessage(BuildContext context) async {
    if (ObjectUtil.stringIsNotBlank(state.msgController.text)) {
      MessageEntity res = await state.messageService.sendTextMessageInSingleChat(state.msgController.text, state.currentConversation.value.userID!);
      if (ObjectUtil.stringIsNotBlank(res.msgID)) {
        state.historyMessage.insert(0, res);
        state.msgController.text = "";
        FocusScope.of(context).requestFocus(FocusNode());
      }
    }
  }

  // 添加消息列表滚动监听器
  void messageListScrollListener() {
    state.chatListScrollController.addListener(() {
      if (state.chatListScrollController.position.pixels >= state.chatListScrollController.position.maxScrollExtent * .85) {
        loadMoreMessage();
      }
    });
  }

  // 跳转至好友信息界面
  void jumpToFriendInfo() async {
    if (Get.previousRoute == RouteName.androidFriendInfo) {
      Get.back();
    } else {
      UserFriend userFriend = await state.friendShipService.getFriendInfoById(state.currentConversation.value.userID!);
      if (ObjectUtil.stringIsNotBlank(userFriend.username)) {
        Get.toNamed(RouteName.androidFriendInfo, arguments: userFriend);
      } else {
        ToastUtil.errorToast("好友资料获取失败");
      }
    }
  }

}
