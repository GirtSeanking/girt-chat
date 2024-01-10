import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';

import 'state.dart';

class SettingLogic extends GetxController {
  final SettingState state = SettingState();

  void logout() async {
    await state.userService.logout();
    Get.offNamed(RouteName.login);
  }
}
