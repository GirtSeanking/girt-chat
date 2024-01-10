import 'package:girt_chat/common/entities/user/user_apply.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_check_result.dart';

abstract class IFriendShipService {
  Future<bool> sendFriendApply(
      String username, String remark, String addWording);
  Future<Map<String, dynamic>> getFriendApplicationList();
  Future<List<UserFriend>> getFriendList();
  Future<UserFriend> getFriendInfoById(String userId);
  Future<List<V2TimFriendCheckResult>?> checkFriendShip(List<String> userIds);
  Future<void> setFriendApplicationRead();
  Future<bool> acceptFriendApplication(UserApply userApply);
  Future<bool> setRemark(String value, UserFriend userFriend);
}
