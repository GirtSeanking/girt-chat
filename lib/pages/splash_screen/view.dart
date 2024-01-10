import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:girt_chat/pages/public/chroma_logo.dart';
import 'package:girt_chat/pages/public/login_register_background.dart';

import 'logic.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SplashScreenLogic>();
    final state = Get.find<SplashScreenLogic>().state;

    return LoginOrRegisterPageBackground(
      children: [
        const ChromaLogo(),
        Gap(getHeight(30)),
        Obx(() {
          if (ObjectUtil.stringIsNotBlank(state.user.value.username)) {
            return Column(
              children: [
                AppAvatar(
                  name: state.user.value.nickName!,
                  image: state.user.value.photoUrl != null
                      ? NetworkImage(state.user.value.photoUrl!)
                      : null,
                  size: 100,
                ),
                Gap(getHeight(30)),
                Text(
                  state.user.value.nickName!,
                  style: AppTexts.defaultStyles.copyWith(fontSize: 20),
                ),
                Gap(getHeight(20)),
                AppButton(
                  text: "登录",
                  onPressed: () {
                    logic.windowsLogin();
                  },
                  bgColor: AppColors.primaryColor,
                  textColor: Colors.white,
                ),
                Gap(getHeight(20)),
                InkWell(
                  onTap: () {
                    Get.offAndToNamed(RouteName.login);
                  },
                  child: Text(
                    "添加账号",
                    style: AppTexts.defaultStyles
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
