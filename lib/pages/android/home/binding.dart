import 'package:get/get.dart';
import 'package:girt_chat/pages/android/message_list/logic.dart';
import 'package:girt_chat/pages/android/my_space/logic.dart';
import 'package:girt_chat/pages/android/ring/logic.dart';

import 'logic.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => MessageListLogic());
    Get.lazyPut(() => RingLogic());
    Get.lazyPut(() => MySpaceLogic());
  }
}
