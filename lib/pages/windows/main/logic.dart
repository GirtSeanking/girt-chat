import 'package:get/get.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:window_manager/window_manager.dart';

import 'state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  @override
  void onInit() {
    super.onInit();
    windowManager.setMaximumSize(windowMaxSize8K);
  }
}
