import 'package:get/get.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class MySpaceState {
  UserService userService = UserService();

  RxString nickName = "".obs;
  RxString selfSignature = "".obs;
  RxString imageUrl = "".obs;
}
