import 'package:girt_chat/common/entities/user/user_entity.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_application.dart';

class UserApply extends UserEntity {
  String? addWording;
  int? addTime;
  int? type;

  UserApply.fromV2TimFriendApplication(V2TimFriendApplication json) {
    username = json.userID;
    nickName = json.nickname;
    photoUrl = json.faceUrl;
    addWording = json.addWording;
    addTime = json.addTime;
    type = json.type;
  }
}