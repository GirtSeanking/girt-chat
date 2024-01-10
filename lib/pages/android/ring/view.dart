import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RingPage extends StatelessWidget {
  const RingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RingLogic>();
    final state = Get.find<RingLogic>().state;

    return Scaffold(
      body: Center(
        child: Text("RingPage"),
      ),
    );
  }
}
