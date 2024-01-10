import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_friend_info.dart';

import 'state.dart';

class MessageListLogic extends GetxController {
  final MessageListState state = MessageListState();

  @override
  void onReady() {
    getFriendShipApplicationList();
    getConversationList();
    super.onReady();
  }

  // 获取会话列表
  getConversationList() async {
    List<V2TimConversation?>? list =
        await state.messageService.getConversationList();
    state.conversationList.clear();
    if (list != null && list.isNotEmpty) {
      for (var value in list) {
        if (value != null && value.conversationID.isNotEmpty) {
          state.conversationList
              .add(ConversationEntity.fromV2TIMConversation(value));
        }
      }
    }
  }

  // 获取好友申请信息
  void getFriendShipApplicationList() async {
    var res = await state.friendShipService.getFriendApplicationList();
    state.friendApplicationUnread.value = res['unreadCount'];
    if (state.friendApplicationUnread.value > 0) {
      HomeLogic homeLogic = Get.find();
      homeLogic.messageUnreadAdd(state.friendApplicationUnread.value);
    }
  }

  // 设置好友申请已读
  void setFriendApplicationRead() {
    if (state.friendApplicationUnread.value > 0) {
      int temp = state.friendApplicationUnread.value;
      state.friendApplicationUnread.value = 0;
      HomeLogic homeLogic = Get.find();
      homeLogic.messageUnreadSub(temp);
    }
  }

  // 打开聊天界面
  void openChatPage(ConversationEntity item) {
    Get.toNamed(RouteName.androidChatPage, arguments: item);
  }

  // 会话改变重新渲染
  void onConversationChanged(List<V2TimConversation> conversationList) {
    List<ConversationEntity> tempList = [];
    List<ConversationEntity> newList = [];
    tempList.addAll(state.conversationList);

    for (int i = 0; i < conversationList.length; i ++) {
      V2TimConversation newVal = conversationList[i];
      for (int j = 0; j < tempList.length; j ++) {
        ConversationEntity value = tempList[i];
        if (value.conversationID == newVal.conversationID) {
          tempList.remove(value);
        }
      }
      newList.add(ConversationEntity.fromV2TIMConversation(newVal));
    }
    state.conversationList.clear();
    state.conversationList.addAll(newList);
    state.conversationList.addAll(tempList);
  }

  // 会话显示名字改变重新渲染（来自修改好友备注）
  void upgradeConversationShowName(List<V2TimFriendInfo> infoList) {
    List<ConversationEntity> tempList = [];
    tempList.addAll(state.conversationList);
    for (V2TimFriendInfo vtItem in infoList) {
      for (ConversationEntity c in tempList) {
        if (c.userID == vtItem.userID) {
          if (ObjectUtil.stringIsNotBlank(vtItem.friendRemark)) {
            c.showName = vtItem.friendRemark;
          }
        }
      }
    }
    state.conversationList.clear();
    state.conversationList.addAll(tempList);
  }
}
