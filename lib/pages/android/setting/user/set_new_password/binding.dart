import 'package:get/get.dart';

import 'logic.dart';

class SetNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetNewPasswordLogic());
  }
}
