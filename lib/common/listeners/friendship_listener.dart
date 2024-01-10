import 'package:get/get.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/pages/android/friend/friend_list/logic.dart';
import 'package:girt_chat/pages/android/message_list/logic.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimFriendshipListener.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_application.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';

class FriendshipListener {
  V2TimFriendshipListener listener() {
    LogService.to.log("创建好友关系链监听器");
    return V2TimFriendshipListener(
      onFriendApplicationListAdded:
          (List<V2TimFriendApplication> applicationList) {
        MessageListLogic logic = Get.find();
        logic.getFriendShipApplicationList();
      },
      onFriendApplicationListRead: () {
        MessageListLogic logic = Get.find();
        logic.setFriendApplicationRead();
      },
      onFriendInfoChanged: (List<V2TimFriendInfo> infoList) {
        //好友信息改变的回调
        //infoList 好友信息改变的好友列表
        try {
          MessageListLogic messageListLogic = Get.find();
          FriendListLogic friendListLogic = Get.find();
          friendListLogic.upgradeFriendList(infoList);
          messageListLogic.upgradeConversationShowName(infoList);
        } catch (_) {
          rethrow;
        }
      },
    );
  }
}
