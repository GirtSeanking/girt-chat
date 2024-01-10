import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/pages/android/message_list/view.dart';
import 'package:girt_chat/pages/android/my_space/view.dart';
import 'package:girt_chat/pages/android/ring/view.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeLogic>();
    final state = Get.find<HomeLogic>().state;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: state.pageController,
        children: const <Widget>[
          MessageListPage(),
          RingPage(),
          MySpacePage(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return CustomNavigationBar(
          currentIndex: state.page.value,
          selectedColor: AppColors.primaryColor,
          strokeColor: AppColors.primaryColor,
          items: [
            CustomNavigationBarItem(
              icon: Badge(
                label: Text(state.messageListUnread.value > 99
                    ? "99+"
                    : state.messageListUnread.value.toString()),
                isLabelVisible: state.messageListUnread.value > 0,
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600,),
                child: const Icon(FluentIcons.chat_sparkle_16_regular),
              ),
              selectedIcon: Badge(
                label: Text(state.messageListUnread.value > 99
                    ? "99+"
                    : state.messageListUnread.value.toString()),
                isLabelVisible: state.messageListUnread.value > 0,
                textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600,),
                child: const Icon(FluentIcons.chat_sparkle_16_filled),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(FluentIcons.earth_16_regular),
              selectedIcon: const Icon(FluentIcons.earth_leaf_16_filled),
            ),
            CustomNavigationBarItem(
              icon: const Icon(FluentIcons.person_16_regular),
              selectedIcon: const Icon(FluentIcons.person_16_filled),
            ),
          ],
          onTap: logic.handlePageChanged,
        );
      }),
    );
  }
}
