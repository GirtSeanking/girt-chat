import 'package:girt_chat/common/utils/date_util.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_text_elem.dart';

class MessageEntity {
  String? msgID;
  String? userID;
  String? nickName;
  String? faceURL;
  String? sender;
  String? friendRemark;
  String? timestamp;
  int? elemType;
  String? textElem;
  bool? isRead;
  bool? isPeerRead;

  MessageEntity(
      {this.msgID,
        this.userID,
        this.nickName,
        this.faceURL,
        this.sender,
        this.friendRemark,
        this.timestamp,
        this.elemType,
        this.textElem,
        this.isRead,
        this.isPeerRead});

  MessageEntity.fromJson(Map<String, dynamic> json) {
    msgID = json['msgID'];
    userID = json['userID'];
    nickName = json['nickName'];
    faceURL = json['faceURL'];
    sender = json['sender'];
    friendRemark = json['friendRemark'];
    timestamp = json['timestamp'];
    elemType = json['elemType'];
    textElem = json['textElem'];
    isRead = json['isRead'];
    isPeerRead = json['isPeerRead'];
  }

  MessageEntity.fromV2TimMessage(V2TimMessage data) {
    msgID = data.msgID;
    userID = data.userID;
    nickName = data.nickName;
    faceURL = data.faceUrl;
    sender = data.sender;
    friendRemark = data.friendRemark;
    timestamp = data.timestamp == null ? "" : DateUtil.convertMsgTime(data.timestamp!);
    elemType = data.elemType;
    textElem = data.textElem == null ? "" : data.textElem!.text;
    isRead = data.isRead;
    isPeerRead = data.isPeerRead;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msgID'] = msgID;
    data['userID'] = userID;
    data['nickName'] = nickName;
    data['faceURL'] = faceURL;
    data['sender'] = sender;
    data['friendRemark'] = friendRemark;
    data['timestamp'] = timestamp;
    data['elemType'] = elemType;
    data['textElem'] = textElem;
    data['isRead'] = isRead;
    data['isPeerRead'] = isPeerRead;
    return data;
  }
}
