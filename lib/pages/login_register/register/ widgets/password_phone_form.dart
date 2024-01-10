
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/login_register/register/logic.dart';

class PasswordPhoneForm extends StatelessWidget {
  const PasswordPhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Get
        .find<RegisterLogic>()
        .state;
    return SizedBox(
      height: getHeight(280),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "passwordInputLabel".tr,
            style: AppTexts.defaultStyles,
          ),
          Gap(getHeight(15)),
          Container(
            width: getWidth(220),
            height: getHeight(50),
            padding: EdgeInsets.all(getWidth(10)),
            decoration: BoxDecoration(
                border:
                Border.all(color: Colors.black54, width: 2),
                borderRadius:
                BorderRadius.circular(getHeight(8))),
            child: Row(
              children: [
                const Icon(FluentIcons.lock_shield_20_regular),
                Expanded(
                  child: TextField(
                    controller: state.passwordController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, counterText: ""),
                    cursorColor: AppColors.primaryColor,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          Gap(getHeight(20)),
          Text(
            "phoneInputLabel".tr,
            style: AppTexts.defaultStyles,
          ),
          Gap(getHeight(15)),
          Container(
            width: getWidth(220),
            height: getHeight(50),
            padding: EdgeInsets.all(getWidth(10)),
            decoration: BoxDecoration(
                border:
                Border.all(color: Colors.black54, width: 2),
                borderRadius:
                BorderRadius.circular(getHeight(8))),
            child: Row(
              children: [
                const Icon(FluentIcons.phone_12_regular),
                Expanded(
                  child: TextField(
                    controller: state.phoneController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, counterText: ""),
                    cursorColor: AppColors.primaryColor,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
