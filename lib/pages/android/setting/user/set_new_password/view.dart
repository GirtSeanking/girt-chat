import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/input.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';

import 'logic.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SetNewPasswordLogic>();
    final state = Get.find<SetNewPasswordLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          AndroidPageHead(
            label: "修改密码",
            buttonText: "确认",
            buttonOnClick: () {
              logic.updatePassword();
            },
          ),
          const AndroidInput(hintText: "请输入原密码",),
          const Gap(20),
          const AndroidInput(hintText: "请输入新密码",),
          const Gap(20),
          const AndroidInput(hintText: "再次输入新密码",),
        ],
      ),
    );
  }
}
