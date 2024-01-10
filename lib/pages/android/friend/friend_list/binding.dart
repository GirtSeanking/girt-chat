import 'package:get/get.dart';
import 'package:girt_chat/pages/android/friend/friend_list/logic.dart';

class FriendListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendListLogic());
  }
}
