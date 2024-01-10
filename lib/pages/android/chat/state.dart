import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';
import 'package:girt_chat/service/message/message_service_impl.dart';

class ChatState {
  FriendShipService friendShipService = FriendShipService();
  MessageService messageService = MessageService();

  Rx<ConversationEntity> currentConversation = Rx(ConversationEntity());

  RxList<MessageEntity> historyMessage = <MessageEntity>[].obs;

  TextEditingController msgController = TextEditingController();

  ScrollController chatListScrollController = ScrollController();
}
