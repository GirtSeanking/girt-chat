import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/friends/firends_service_impl.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class NewFriendSearchState {
  UserService userService = UserService();
  FriendShipService friendShipService = FriendShipService();

  TextEditingController searchController = TextEditingController();

  // 查询为空显示
  RxBool searchEmpty = false.obs;

  // 展示列表
  RxList<UserVo> searchResult = <UserVo>[].obs;

  // 加载状态
  RxBool searchLoading = false.obs;

  // 好友申请信息
  UserVo userApply = UserVo();

  // 好友申请备注设置编辑框控制器
  TextEditingController remarkController = TextEditingController();
  // 好友申请验证消息编辑框控制器
  TextEditingController applyWordingController = TextEditingController();
}
