import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';

class FriendListState {
  final FriendShipService friendShipService = FriendShipService();

  RxList<UserFriend> friendList = <UserFriend>[].obs;

  final List<String> az = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "#"
  ];

  RxMap<String, List<UserFriend>> contractMap = <String, List<UserFriend>>{}.obs;

  //  界面滚动监听器
  ScrollController pageViewScrollController = ScrollController();

  // 顶部显示index
  RxInt selectedIndex = Constants.unSelected.obs;

  // 气泡是否显示
  RxBool bubbleShow = false.obs;

  // 索引是否显示
  RxBool indexShow = false.obs;

  TextEditingController searchController = TextEditingController();
}
