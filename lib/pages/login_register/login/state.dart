import 'package:flutter/cupertino.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class LoginState {

  // 用户服务
  UserService userService = UserService();

  // 用户名编辑框控制器
  TextEditingController usernameController = TextEditingController();
  // 密码编辑框控制器
  TextEditingController passwordController = TextEditingController();
}
