import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/item_button.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SettingLogic>();
    final state = Get.find<SettingLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          const AndroidPageHead(
            label: "设置",
          ),
          AndroidItemButton(
            iconData: FluentIcons.person_32_regular,
            onTap: () {
              Get.toNamed(RouteName.androidAccountAndSecurity);
            },
            label: "账户与安全",
          ),
          SizedBox(
            width: getWidthByRatio(.85),
            child: Divider(
              color: Colors.grey.shade300,
            ),
          ),
          AndroidItemButton(
            onTap: logic.logout,
            label: "退出登录",
            iconData: FluentIcons.power_20_filled,
          )
        ],
      ),
    );
  }
}
