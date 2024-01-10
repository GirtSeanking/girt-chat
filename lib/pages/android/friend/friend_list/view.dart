import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/android/friend/friend_list/painters/painter_letter.dart';
import 'package:girt_chat/pages/android/friend/friend_list/widgets/contract_children.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';
import 'package:girt_chat/pages/android/public/search_input.dart';
import 'package:girt_chat/pages/android/public/search_input_btn.dart';

import 'logic.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FriendListLogic>();
    final state = logic.state;
    return AndroidBackground(
      child: SizedBox(
        height: getScreenHeight(),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: state.pageViewScrollController,
              child: Column(
                children: [
                  const AndroidPageHead(
                    label: "联系人",
                  ),
                  Gap(getHeight(20)),
                  const AndroidSearchInputBtn(),
                  Gap(getHeight(20)),
                  Obx(() {
                    return Column(
                      children: state.contractMap.keys.map((key) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: getWidth(20)),
                                child: Text(
                                  key: Get.nestedKey(key),
                                  key,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ContractChildren(list: state.contractMap[key]!),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  })
                ],
              ),
            ),
            Obx(() {
              if (state.indexShow.value) {
                return Positioned(
                  right: 0,
                  height: getScreenHeight(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          state.pageViewScrollController.jumpTo(0);
                        },
                        child: const Icon(
                          FluentIcons.search_24_regular,
                          size: 14,
                        ),
                      ),
                      GestureDetector(
                        onVerticalDragDown: logic.onDragDown,
                        onVerticalDragUpdate: logic.onDragUpdate,
                        onVerticalDragEnd: logic.onDragEnd,
                        child: Column(
                          children: state.contractMap.keys.map((e) {
                            bool isCurrent = false;
                            if (state.selectedIndex.value !=
                                    Constants.unSelected &&
                                e ==
                                    state.contractMap.keys
                                        .toList()[state.selectedIndex.value]) {
                              isCurrent = true;
                            }
                            return Stack(
                              children: [
                                if (isCurrent && state.bubbleShow.value)
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CustomPaint(
                                      painter: PainterLetter(e),
                                    ),
                                  ),
                                Container(
                                  padding: const EdgeInsets.all(2.5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isCurrent
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      color: isCurrent
                                          ? Colors.white
                                          : Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
            Obx(() {
              if (state.selectedIndex.value != Constants.unSelected) {
                return Positioned(
                  top: 0,
                  width: getScreenWidth(),
                  child: Container(
                    padding: EdgeInsets.only(left: getWidth(30)),
                    color: const Color(0xFFF9F8F9),
                    child: Text(
                      state.contractMap.keys
                          .toList()[state.selectedIndex.value],
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
