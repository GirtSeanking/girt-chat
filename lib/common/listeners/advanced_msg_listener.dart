import 'package:get/get.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/pages/android/chat/logic.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/message_elem_type.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_receipt.dart';

class AdvancedMsgListener {
  V2TimAdvancedMsgListener listener() {
    LogService.to.log("创建消息监听器");
    return V2TimAdvancedMsgListener(
      onRecvC2CReadReceipt: (List<V2TimMessageReceipt> receiptList) {
        //单聊已读回调
      },
      onRecvMessageRevoked: (String messageId) {
        // 在本地维护的消息中处理被对方撤回的消息
      },
      onRecvNewMessage: (V2TimMessage message) async {
        try {
          final chatLogic = Get.find<ChatLogic>();
          // 处理文本消息
          if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_TEXT) {
            chatLogic.receiveMsg(MessageEntity.fromV2TimMessage(message));
          }
        } catch (_) {
          rethrow;
        }
      },
    );
  }
}
