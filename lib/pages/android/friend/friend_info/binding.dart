import 'package:get/get.dart';

import 'logic.dart';

class FriendInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendInfoLogic());
  }
}
