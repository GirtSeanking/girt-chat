import 'package:girt_chat/common/constants/database_name.dart';
import 'package:girt_chat/common/entities/user/user_entity.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_user_full_info.dart';

class UserVo extends UserEntity {
  String? objectId;

  LCObject toLC() {
    LCObject data = LCObject(databaseUser);
    data['username'] = username;
    data['photoUrl'] = photoUrl ?? "";
    data['nickName'] = nickName ?? "";
    data['phone'] = phone ?? "";
    data['birthday'] = birthday ?? "";
    data['sex'] = sex ?? "";
    data['androidOnline'] = androidOnline ?? false;
    data['windowOnline'] = windowOnline ?? false;
    data['isLogin'] = isLogin ?? false;
    return data;
  }

  UserVo.fromLC(LCObject data) {
    username = data['username'];
    photoUrl = data['photoUrl'];
    nickName = data['nickName'];
    phone = data['phone'];
    birthday = data['birthday'];
    sex = data['sex'];
    androidOnline = data['androidOnline'];
    windowOnline = data['windowOnline'];
    isLogin = data['isLogin'];
  }

  UserVo({String? username, String? password})
      : super(username: username, password: password);

  UserVo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    photoUrl = json['photoUrl'];
    nickName = json['nickName'];
    phone = json['phone'];
    birthday = json['birthday'];
    sex = json['sex'];
    androidOnline = json['androidOnline'];
    windowOnline = json['windowOnline'];
    isLogin = json['isLogin'];
  }

  V2TimUserFullInfo toV2TimUserFullInfo() {
    return V2TimUserFullInfo(
      userID: username,
      nickName: nickName,
      faceUrl: photoUrl,
      birthday:
          ObjectUtil.stringIsNotBlank(birthday) ? int.tryParse(birthday!) : 0,
      selfSignature: selfSignature,
      gender: ObjectUtil.stringIsNotBlank(sex) ? int.tryParse(sex!) : 1,
    );
  }

  void upgradeUserFullInfo(V2TimUserFullInfo info) {
    nickName = info.nickName;
    photoUrl = info.faceUrl;
    birthday = info.birthday.toString();
    selfSignature = info.selfSignature;
    sex = info.gender.toString();
  }
}
