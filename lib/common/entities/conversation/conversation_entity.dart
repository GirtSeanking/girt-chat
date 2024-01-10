import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/utils/date_util.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';

class ConversationEntity {
  String? conversationID;
  String? userID;
  String? showName;
  String? faceUrl;
  int? unreadCount;
  String? draftText;
  String? draftTimestamp;
  bool? isPinned;
  int? orderKey;
  MessageEntity? lastMessage;

  ConversationEntity(
      {this.conversationID,
        this.userID,
        this.showName,
        this.faceUrl,
        this.unreadCount,
        this.draftText,
        this.draftTimestamp,
        this.isPinned,
        this.orderKey});

  ConversationEntity.fromJson(Map<String, dynamic> json) {
    conversationID = json['conversationID'];
    userID = json['userID'];
    showName = json['showName'];
    faceUrl = json['faceUrl'];
    unreadCount = json['unreadCount'];
    draftText = json['draftText'];
    draftTimestamp = json['draftTimestamp'];
    isPinned = json['isPinned'];
    orderKey = json['orderKey'];
  }

  ConversationEntity.fromV2TIMConversation(V2TimConversation data) {
    conversationID = data.conversationID;
    userID = data.userID;
    showName = data.showName;
    faceUrl = data.faceUrl;
    unreadCount = data.unreadCount ?? 0;
    draftText = data.draftText;
    draftTimestamp = data.draftTimestamp == null ? "" : DateUtil.convertMsgTime(data.draftTimestamp!);
    isPinned = data.isPinned ?? false;
    orderKey = data.orderkey ?? -1;
    lastMessage = data.lastMessage == null ? MessageEntity() : MessageEntity.fromV2TimMessage(data.lastMessage!);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationID'] = conversationID;
    data['userID'] = userID;
    data['showName'] = showName;
    data['faceUrl'] = faceUrl;
    data['unreadCount'] = unreadCount;
    data['draftText'] = draftText;
    data['draftTimestamp'] = draftTimestamp;
    data['isPinned'] = isPinned;
    data['orderKey'] = orderKey;
    return data;
  }

  ConversationEntity.fromUserFriend(UserFriend userFriend) {
    userID = userFriend.username;
    showName = ObjectUtil.stringIsNotBlank(userFriend.friendRemark) ? userFriend.friendRemark : ObjectUtil.stringIsNotBlank(userFriend.nickName) ? userFriend.nickName : userFriend.username ?? "";
    faceUrl = userFriend.photoUrl;
  }
}
