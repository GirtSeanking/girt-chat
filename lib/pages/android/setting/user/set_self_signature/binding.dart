import 'package:get/get.dart';

import 'logic.dart';

class SetSelfSignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetSelfSignatureLogic());
  }
}
