import 'package:get/get.dart';

import 'logic.dart';

class SetBirthDayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetBirthDayLogic());
  }
}
