import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/public/chroma_logo.dart';
import 'package:girt_chat/pages/public/login_register_background.dart';
import 'package:girt_chat/pages/public/buttons.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<LoginLogic>();
    final state = Get.find<LoginLogic>().state;


    return LoginOrRegisterPageBackground(children: [
      const ChromaLogo(),
      Text(
        "loginSubTitle".tr,
        style: AppTexts.defaultStyles.copyWith(fontSize: 20),
      ),
      Gap(getHeight(20)),
      Container(
        width: getWidth(220),
        height: getHeight(50),
        padding: EdgeInsets.all(getWidth(10)),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(getHeight(8))),
        child: Row(
          children: [
            Icon(
              FluentIcons.person_20_regular,
              size: getWidth(25),
            ),
            Expanded(
              child: TextField(
                controller: state.usernameController,
                decoration:
                const InputDecoration(border: InputBorder.none),
                cursorColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      Gap(getHeight(10)),
      Container(
        width: getWidth(220),
        height: getHeight(50),
        padding: EdgeInsets.all(getWidth(10)),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(getHeight(8))),
        child: Row(
          children: [
            Icon(
              FluentIcons.lock_shield_20_regular,
              size: getWidth(25),
            ),
            Expanded(
              child: TextField(
                controller: state.passwordController,
                decoration:
                const InputDecoration(border: InputBorder.none),
                cursorColor: AppColors.primaryColor,
                obscureText: true,
              ),
            ),
          ],
        ),
      ),
      Gap(getHeight(40)),
      AppButton(
        text: "login".tr,
        onPressed: () {
          logic.handleLogin();
        },
        bgColor: AppColors.primaryColor,
        textColor: Colors.white,
      ),
      Gap(getHeight(10)),
      AppButton(
        text: "registerNewUser".tr,
        onPressed: () {
          Get.toNamed(RouteName.register);
        },
        bgColor: const Color(0xFFEDEEF0),
      ),
    ]);
  }
}
