import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_apply.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';

class FriendApplyListState {
  FriendShipService friendShipService = FriendShipService();

  TextEditingController searchController = TextEditingController();

  // 查询为空显示
  RxBool searchEmpty = false.obs;

  // 展示列表
  RxList<UserApply> searchResult = <UserApply>[].obs;

  // 加载状态
  RxBool searchLoading = false.obs;
}
