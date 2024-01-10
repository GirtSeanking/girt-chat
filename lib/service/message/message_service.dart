import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

abstract class IMessageService {
  Future<MessageEntity> sendTextMessageInSingleChat(String text, String receiveId);
  Future<List<V2TimConversation?>?> getConversationList();
  Future<List<MessageEntity>> getHistoryMessage(String? lastMsgId, String userId);
  Future<void> setMessageListRead(String userId);
  Future<void> clearAllHistoryMessage();
}