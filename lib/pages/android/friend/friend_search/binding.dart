import 'package:get/get.dart';

import 'logic.dart';

class FriendSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendSearchLogic());
  }
}
