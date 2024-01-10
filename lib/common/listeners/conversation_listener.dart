import 'package:get/get.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/pages/android/message_list/logic.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimConversationListener.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

class ConversationListener {
  V2TimConversationListener listener() {
    LogService.to.log("创建会话监听器");
    return V2TimConversationListener(
        onConversationChanged: (List<V2TimConversation> conversationList) {
          MessageListLogic logic = Get.find();
          logic.onConversationChanged(conversationList);
        }
    );
  }
}