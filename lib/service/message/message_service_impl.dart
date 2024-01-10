import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/utils/generate_user_sig.dart';
import 'package:girt_chat/service/message/message_service.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';
import 'package:tencent_cloud_chat_sdk/enum/message_priority_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class MessageService implements IMessageService {

  UserService _userService = UserService();

  @override
  Future<MessageEntity> sendTextMessageInSingleChat(
      String text, String receiveId) async {
    V2TimValueCallback<V2TimMsgCreateInfoResult> messageText =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createTextMessage(text: text);
    if (messageText.code == 0) {
      String? id = messageText.data?.id;
      V2TimValueCallback<V2TimMessage> sendMessageRes =
          await TencentImSDKPlugin.v2TIMManager.getMessageManager().sendMessage(
              id: id!,
              receiver: receiveId,
              groupID: "",
              priority: MessagePriorityEnum.V2TIM_PRIORITY_DEFAULT,
              onlineUserOnly: false,
          );

      return MessageEntity.fromV2TimMessage(sendMessageRes.data!);
    }
    return MessageEntity();
  }

  @override
  Future<List<V2TimConversation?>?> getConversationList() async {
    V2TimValueCallback<V2TimConversationResult> getConversationRes =
        await TencentImSDKPlugin.v2TIMManager
            .getConversationManager()
            .getConversationList(nextSeq: "0", count: 100);
    if (getConversationRes.code == 0) {
      bool? isFinished = getConversationRes.data?.isFinished;
      String? nextSeq = getConversationRes.data?.nextSeq;
      List<V2TimConversation?>? conversationList =
          getConversationRes.data?.conversationList;
      if (!isFinished!) {
        V2TimValueCallback<V2TimConversationResult> nextConversationListRes =
            await TencentImSDKPlugin.v2TIMManager
                .getConversationManager()
                .getConversationList(nextSeq: nextSeq = "0", count: 100);
        conversationList?.addAll(nextConversationListRes.data?.conversationList ?? []);
      }

      return conversationList;
    }
    return null;
  }

  @override
  Future<List<MessageEntity>> getHistoryMessage(String? lastMsgId, String userId) async {
    V2TimValueCallback<List<V2TimMessage>> getHistoryMessageListRes = await TencentImSDKPlugin.v2TIMManager.getMessageManager().getC2CHistoryMessageList(
      userID: userId,
      count: 13,
      lastMsgID: lastMsgId,
    );
    List<MessageEntity> res = [];
    if (getHistoryMessageListRes.code == 0 && getHistoryMessageListRes.data != null) {
      for (var element in getHistoryMessageListRes.data!) {
        res.add(MessageEntity.fromV2TimMessage(element));
        // TencentImSDKPlugin.v2TIMManager.getMessageManager().deleteMessageFromLocalStorage(msgID: element.msgID!);
        // TencentImSDKPlugin.v2TIMManager.getMessageManager().deleteMessages(msgIDs: [element.msgID!]);
      }
    }
    return res;
    // return res.reversed.toList();
  }

  @override
  Future<void> setMessageListRead(String userId) async {
    await TencentImSDKPlugin.v2TIMManager.getMessageManager().markC2CMessageAsRead(userID: userId);
  }

  @override
  Future<void> clearAllHistoryMessage() async {
    UserVo user = await _userService.getCurrentUser() ?? UserVo();
    await TencentImSDKPlugin.v2TIMManager.getMessageManager().clearC2CHistoryMessage(userID: user.username!);
  }
}
