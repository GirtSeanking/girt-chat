import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';

class FriendSearchState {
  FriendShipService friendShipService = FriendShipService();
  TextEditingController searchController = TextEditingController();

  List<UserFriend> friendInfoList = [];
  RxList<UserFriend> showFriendInfoList = <UserFriend>[].obs;
  RxBool isResult = false.obs;
}
