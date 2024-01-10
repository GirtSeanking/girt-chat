import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MainLogic>();
    final state = Get.find<MainLogic>().state;

    return const Scaffold(
      body: Center(
        child: Text("Windows主面板"),
      ),
    );
  }
}
