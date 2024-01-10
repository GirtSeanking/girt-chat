import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/login_register/register/%20widgets/password_phone_form.dart';
import 'package:girt_chat/pages/login_register/register/%20widgets/sex_username_form.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:girt_chat/pages/public/chroma_logo.dart';
import 'package:girt_chat/pages/public/login_register_background.dart';

import 'logic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RegisterLogic>();
    final state = Get
        .find<RegisterLogic>()
        .state;

    return LoginOrRegisterPageBackground(
      children: [
        const ChromaLogo(),
        Obx(() {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            switchInCurve: Curves.easeInCirc,
            switchOutCurve: Curves.easeOutCirc,
            child: state.registerSort.value == 1
                ? const SexUsernameForm()
                : const PasswordPhoneForm(),
          );
        }),
        Gap(getHeight(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                logic.preStep();
              },
              icon: const Icon(FluentIcons.arrow_left_12_regular),
            ),
            Obx(() {
              return AppButton(
                text: state.registerSort.value == 2 ? "registerFinishBtnText".tr : "registerNextBtnText".tr,
                onPressed: () {
                  logic.nextStep();
                },
                width: 130,
                bgColor: AppColors.primaryColor,
                textColor: Colors.white,
              );
            }),
          ],
        )
      ],
    );
  }
}
