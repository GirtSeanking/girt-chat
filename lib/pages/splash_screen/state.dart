import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class SplashScreenState {
  UserService userService = UserService();

  // 本地保存的上次登录用户的信息
  Rx<UserVo> user = Rx(UserVo());
}
