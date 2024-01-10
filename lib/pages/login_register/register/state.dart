import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class RegisterState {

  // 用户服务
  UserService userService = UserService();

  // 性别选中(0：未选中，1：男，2：女)
  RxInt selectedSex = Constants.unSex.obs;

  // 注册顺序
  RxInt registerSort = 1.obs;

  // 用户信息
  UserVo user = UserVo();

  // 用户名编辑框控制器
  TextEditingController usernameController = TextEditingController();
  // 密码编辑框控制器
  TextEditingController passwordController = TextEditingController();
  // 手机号编辑框控制器
  TextEditingController phoneController = TextEditingController();
}
