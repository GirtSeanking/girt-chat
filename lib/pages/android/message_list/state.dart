import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';
import 'package:girt_chat/service/message/message_service_impl.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class MessageListState {
  UserService userService = UserService();
  MessageService messageService = MessageService();
  FriendShipService friendShipService = FriendShipService();

  UserVo user = UserVo();

  // 会话列表
  RxList<ConversationEntity> conversationList = <ConversationEntity>[].obs;

  // 好友申请未读消息数
  RxInt friendApplicationUnread = 0.obs;

  TextEditingController searchController = TextEditingController();
}
