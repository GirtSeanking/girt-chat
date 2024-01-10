import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/toast_util.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/item_button.dart';
import 'package:girt_chat/pages/android/public/item_title.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';

import 'logic.dart';

class AccountAndSecurityPage extends StatelessWidget {
  const AccountAndSecurityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<AccountAndSecurityLogic>();
    final state = Get.find<AccountAndSecurityLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          const AndroidPageHead(
            label: "账户与安全",
          ),
          const AndroidItemTitle(title: "个人信息"),
          AndroidItemButton(
            onTap: () {
              Get.toNamed(RouteName.androidSetNickName);
            },
            label: "昵称",
          ),
          AndroidItemButton(
            onTap: () {
              Get.toNamed(RouteName.androidSetBirthday);
            },
            label: "生日",
          ),
          AndroidItemButton(
            onTap: () {
              Get.toNamed(RouteName.androidSetSelfSignature);
            },
            label: "个性签名",
          ),
          const AndroidItemTitle(title: "安全设置"),
          AndroidItemButton(
            onTap: () {
              ToastUtil.warningToast("功能开发中");
              // Get.toNamed(RouteName.androidSetNewPassword);
            },
            label: "修改密码",
          ),
        ],
      ),
    );
  }
}
