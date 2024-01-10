import 'package:girt_chat/common/entities/user/user_entity.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';

class UserFriend extends UserEntity {
  String? friendRemark;
  String? firstLetter;

  UserFriend({this.friendRemark, this.firstLetter});

  UserFriend.fromV2TimFriendInfo(V2TimFriendInfo data) {
    friendRemark = data.friendRemark;
    username = data.userID;
    if (data.userProfile != null) {
      nickName = data.userProfile!.nickName ?? "";
      photoUrl = data.userProfile!.faceUrl!;
    }
    firstLetter =
        ObjectUtil.getFirstUpperCase(ObjectUtil.stringIsNotBlank(friendRemark)
            ? friendRemark
            : ObjectUtil.stringIsNotBlank(nickName)
                ? nickName
                : username);
  }

  UserFriend.fromJson(Map<String, dynamic> json) {
    friendRemark = json['friendRemark'];
    firstLetter = json['firstLetter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friendRemark'] = friendRemark;
    data['firstLetter'] = firstLetter;
    return data;
  }

  void fillInBaseUserInfo(UserVo userVo) {
    sex = userVo.sex;
    phone = userVo.phone;
    birthday = userVo.birthday;
    androidOnline = userVo.androidOnline;
    windowOnline = userVo.windowOnline;
  }
}
