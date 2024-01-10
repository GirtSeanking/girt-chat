import 'package:get/get.dart';
import 'package:girt_chat/common/constants/database_name.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/store/user_store.dart';
import 'package:girt_chat/common/utils/generate_user_sig.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';
import 'package:girt_chat/service/user/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_check_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:uuid/uuid.dart';

class UserService implements IUserService {
  final UserStore _userStore = UserStore();
  final FriendShipService _friendShipService = FriendShipService();

  @override
  Future<bool> loginStorage(UserVo user) async {
    try {
      await LCUser.login(user.username!, user.password!);
      LCQuery query =
          LCQuery(databaseUser).whereEqualTo("username", user.username);
      List<LCObject> userList = await query.find() ?? [];
      if (userList.isNotEmpty) {
        LCObject update =
            LCObject.createWithoutData(databaseUser, userList.first.objectId!);
        UserVo userVo = UserVo.fromLC(userList.first);
        if (GetPlatform.isAndroid) {
          update['androidOnline'] = true;
          userVo.androidOnline = true;
        } else if (GetPlatform.isWindows) {
          update['windowOnline'] = true;
          userVo.windowOnline = true;
        }
        update['isLogin'] = true;
        userVo.isLogin = true;
        userVo.password = user.password;
        userVo.objectId = userList.first.objectId!;
        await update.save();
        _userStore.saveUser(userVo);
      }
      return true;
    } on LCException catch (e) {
      return false;
    }
  }

  @override
  Future<bool> loginIM(UserVo user) async {
    GenerateUserSig generateUserSig = GenerateUserSig();
    String userSig =
        generateUserSig.genSig(identifier: user.username!, expire: 1800000);
    V2TimCallback res = await TencentImSDKPlugin.v2TIMManager
        .login(userID: user.username!, userSig: userSig);
    return res.code == 0;
  }

  @override
  Future<bool> register(UserVo user) async {
    try {
      LCUser lcUser = LCUser();
      lcUser.username = user.username;
      lcUser.password = user.password;
      await lcUser.signUp();

      user.nickName = user.username;
      LCObject lcObject = user.toLC();

      await lcObject.save();
      return true;
    } on LCException catch (e) {
      return false;
    }
  }

  @override
  Future<UserVo?> getLocalIsLoginUser() async {
    List<UserVo> userList = await _userStore.getList();
    for (var value in userList) {
      if (value.isLogin!) {
        return value;
      }
    }
    return null;
  }

  @override
  Future<UserVo?> getCurrentUser() async {
    LCUser? user = await LCUser.getCurrent();
    if (user != null) {
      String username = user.username ?? "";
      LCQuery query = LCQuery(databaseUser).whereEqualTo("username", username);
      List<LCObject> userList = await query.find() ?? [];
      if (userList.isNotEmpty) {
        UserVo user = UserVo.fromLC(userList.first);
        user.objectId = userList.first.objectId;
        return user;
      }
    }
    return null;
  }

  @override
  Future<List<UserVo>> searchUserInfo(String key) async {
    List<UserVo> res = [];
    List<UserVo> databaseRes = [];
    LCUser? user = await LCUser.getCurrent();
    if (user != null) {
      LCQuery query = LCQuery(databaseUser).whereContains("username", key);
      List<LCObject> userList = await query.find() ?? [];
      List<String> userIds = [];
      for (var value in userList) {
        UserVo item = UserVo.fromLC(value);
        if (item.username == user.username) {
          continue;
        }
        if (ObjectUtil.stringIsNotBlank(item.username)) {
          userIds.add(item.username!);
        }
        databaseRes.add(item);
      }
      if (userIds.isNotEmpty) {
        List<V2TimFriendCheckResult>? checkRes =
            await _friendShipService.checkFriendShip(userIds);
        if (checkRes != null && checkRes.isNotEmpty) {
          if (checkRes.length == databaseRes.length) {
            for (int i = 0; i < databaseRes.length; i++) {
              if (checkRes[i].userID == databaseRes[i].username &&
                  checkRes[i].resultType == 0) {
                res.add(databaseRes[i]);
              }
            }
          } else {
            throw Exception(["leancloud 数据与 IM 数据不匹配"]);
          }
        }
      }
    }
    return res;
  }

  @override
  Future<UserVo> getUserInfoByUsername(String username) async {
    LCQuery query = LCQuery(databaseUser).whereContains("username", username);
    List<LCObject> userList = await query.find() ?? [];
    if (userList.isNotEmpty) {
      return UserVo.fromLC(userList.first);
    } else {
      return UserVo();
    }
  }

  @override
  Future<void> updateUserBirthday(String timestamp) async {
    UserVo? user = await getCurrentUser();
    if (user != null) {
      LCObject update =
          LCObject.createWithoutData(databaseUser, user.objectId!);
      user.birthday = timestamp;
      update['birthday'] = timestamp;
      V2TimUserFullInfo userFullInfo = user.toV2TimUserFullInfo();
      await update.save();
      await TencentImSDKPlugin.v2TIMManager
          .setSelfInfo(userFullInfo: userFullInfo);
    }
  }

  @override
  Future<void> logout() async {
    UserVo? user = await getCurrentUser();
    if (user != null) {
      // 退出LeanCloud 数据库
      LCObject update =
          LCObject.createWithoutData(databaseUser, user.objectId!);
      if (GetPlatform.isAndroid) {
        update['androidOnline'] = false;
        user.androidOnline = false;
      } else if (GetPlatform.isWindows) {
        update['windowOnline'] = false;
        user.windowOnline = false;
      }
      update['isLogin'] = false;
      user.isLogin = false;
      await update.save();
      _userStore.saveUser(user);

      // 退出 IM 即时通讯
      await TencentImSDKPlugin.v2TIMManager.logout();
    }
  }

  @override
  Future<void> saveNewNickName(UserVo userVo) async {
    UserVo? user = await getCurrentUser();
    if (user != null) {
      // 修改 LeanCloud 存储的用户信息
      LCObject update =
          LCObject.createWithoutData(databaseUser, user.objectId!);
      update['nickName'] = userVo.nickName;
      await update.save();
      // 修改本地保存的用户信息
      // user.nickName = userVo.nickName;
      // _userStore.saveUser(user);
      // 设置 IM 即时通讯个人资料
      TencentImSDKPlugin.v2TIMManager.setSelfInfo(
          userFullInfo: V2TimUserFullInfo(
              nickName: userVo.nickName, role: 0, faceUrl: userVo.photoUrl, selfSignature: userVo.selfSignature));
    }
  }

  @override
  Future<void> saveAvatar(ImageSource imageSource) async {
    UserVo? user = await getCurrentUser();
    if (user != null) {
      XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
      if (pickImage != null) {
        var uuid = Uuid();
        String imageName = uuid.v5(Namespace.URL, user.username!);
        LCFile file = await LCFile.fromPath(imageName, pickImage.path);
        await file.save();
        String? imageUrl = file.url;
        if (ObjectUtil.stringIsNotBlank(imageUrl)) {
          LCObject update =
              LCObject.createWithoutData(databaseUser, user.objectId!);
          update['photoUrl'] = imageUrl;
          await update.save();
          TencentImSDKPlugin.v2TIMManager.setSelfInfo(
              userFullInfo: V2TimUserFullInfo(
                  nickName: user.nickName, role: 0, faceUrl: imageUrl, selfSignature: user.selfSignature));
        }
      }
    }
  }

  @override
  Future<void> saveNewSelfSignature(UserVo userVo) async {
    UserVo? user = await getCurrentUser();
    if (user != null) {
      // 修改 LeanCloud 存储的用户信息
      LCObject update =
      LCObject.createWithoutData(databaseUser, user.objectId!);
      update['selfSignature'] = userVo.selfSignature;
      await update.save();
      // 修改本地保存的用户信息
      // user.nickName = userVo.nickName;
      // _userStore.saveUser(user);
      // 设置 IM 即时通讯个人资料
      TencentImSDKPlugin.v2TIMManager.setSelfInfo(
          userFullInfo: V2TimUserFullInfo(
              nickName: userVo.nickName, role: 0, faceUrl: userVo.photoUrl, selfSignature: userVo.selfSignature));
    }
  }

}
