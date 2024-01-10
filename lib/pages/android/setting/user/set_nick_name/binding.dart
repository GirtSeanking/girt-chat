import 'package:get/get.dart';

import 'logic.dart';

class SetNickNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetNickNameLogic());
  }
}
