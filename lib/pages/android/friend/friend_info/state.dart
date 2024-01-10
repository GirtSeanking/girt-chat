import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class FriendInfoState {
  UserService userService = UserService();
  FriendShipService friendShipService = FriendShipService();
  Rx<UserFriend> currentUserFriend = Rx(UserFriend());

  RxBool userInfoLoading = true.obs;
}
