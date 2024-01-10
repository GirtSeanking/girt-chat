import 'package:girt_chat/common/entities/user/user_apply.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/service/friends/friends_service.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_application_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_response_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_application_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_friend_check_result.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_friend_info.dart';

class FriendShipService implements IFriendShipService {
  @override
  Future<bool> sendFriendApply(
      String username, String remark, String addWording) async {
    V2TimValueCallback<V2TimFriendOperationResult> addFriendsRes =
        await TencentImSDKPlugin.v2TIMManager.getFriendshipManager().addFriend(
              userID: username,
              addType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH,
              remark: remark,
              addWording: addWording,
            );
    return addFriendsRes.code == 0;
  }

  @override
  Future<Map<String, dynamic>> getFriendApplicationList() async {
    //获取好友申请列表
    V2TimValueCallback<V2TimFriendApplicationResult>
        getFriendApplicationListRes = await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .getFriendApplicationList();
    Map<String, dynamic> resultJson = {};
    resultJson['unreadCount'] = 0;
    resultJson['list'] = [];
    if (getFriendApplicationListRes.code == 0) {
      // 查询成功
      resultJson['unreadCount'] =
          getFriendApplicationListRes.data?.unreadCount ?? 0;
      resultJson['list'] =
          getFriendApplicationListRes.data?.friendApplicationList ?? [];
    }
    return resultJson;
  }

  @override
  Future<List<UserFriend>> getFriendList() async {
    //获取好友列表
    V2TimValueCallback<List<V2TimFriendInfo>> getFriendListRes =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .getFriendList();
    List<UserFriend> res = [];
    if (getFriendListRes.code == 0) {
      // 查询成功
      for (V2TimFriendInfo item in getFriendListRes.data ?? []) {
        res.add(UserFriend.fromV2TimFriendInfo(item));
      }
    }
    return res;
  }

  @override
  Future<UserFriend> getFriendInfoById(String userId) async {
    // 获取指定好友资料
    V2TimValueCallback<List<V2TimFriendInfoResult>> getFriendsInfoRes =
        await TencentImSDKPlugin.v2TIMManager
        .getFriendshipManager()
        .getFriendsInfo(userIDList: [userId]);
    if (getFriendsInfoRes.code == 0) {
      if (ObjectUtil.listIsNotBlank(getFriendsInfoRes.data)) {
        return UserFriend.fromV2TimFriendInfo(getFriendsInfoRes.data!.first.friendInfo!);
      }
    }
    return UserFriend();
  }

  @override
  Future<List<V2TimFriendCheckResult>?> checkFriendShip(
      List<String> userIds) async {
    //检查指定用户的好友关系
    V2TimValueCallback<List<V2TimFriendCheckResult>> checkFriendRes =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .checkFriend(
              userIDList: userIds, //需要检查的用户id列表
              checkType: FriendTypeEnum.V2TIM_FRIEND_TYPE_BOTH, //检查的类型
            );
    if (checkFriendRes.code == 0) {
      // 查询发送成功
      return checkFriendRes.data;
    }
    return null;
  }

  @override
  Future<void> setFriendApplicationRead() async {
    //设置好友申请已读
    TencentImSDKPlugin.v2TIMManager
        .getFriendshipManager()
        .setFriendApplicationRead();
  }

  @override
  Future<bool> acceptFriendApplication(UserApply userApply) async {
    //同意好友申请
    V2TimValueCallback<V2TimFriendOperationResult> acceptFriendApplicationRes =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .acceptFriendApplication(
                responseType: FriendResponseTypeEnum
                    .V2TIM_FRIEND_ACCEPT_AGREE, //建立好友关系时选择单向/双向好友关系
                type: FriendApplicationTypeEnum.values[userApply
                    .type!], //加好友类型 要与getApplicationList查询到的type相同，否则会报错。
                userID: userApply.username!);

    return acceptFriendApplicationRes.code == 0;
  }

  @override
  Future<bool> setRemark(String value, UserFriend userFriend) async {
    String userID = userFriend.username!;
    V2TimCallback setFriendInfoRes = await TencentImSDKPlugin.v2TIMManager
        .getFriendshipManager()
        .setFriendInfo(
          userID: userID, //需要修改的用户id
          friendRemark: value, //修改的好友备注
        );
    if (setFriendInfoRes.code == 0) {
      return true;
    }
    return false;
  }


}
