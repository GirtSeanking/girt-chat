
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/message/message_service_impl.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class HomeState {
  UserService userService = UserService();
  MessageService messageService = MessageService();

  // 页控制器
  PageController pageController = PageController();
  // 当前 tab 页码
  RxInt page = 0.obs;

  // 当前登录用户信息
  Rx<UserVo> user = Rx(UserVo());

  // 消息界面未读消息数
  RxInt messageListUnread = 0.obs;


}
