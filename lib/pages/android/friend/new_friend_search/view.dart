import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';
import 'package:girt_chat/pages/android/public/search_input.dart';
import 'package:girt_chat/pages/public/avatar.dart';

import 'logic.dart';

class NewFriendSearchPage extends StatelessWidget {
  const NewFriendSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<NewFriendSearchLogic>();
    final state = Get.find<NewFriendSearchLogic>().state;

    return Scaffold(
      body: AndroidBackground(
        child: Column(
          children: [
            const AndroidPageHead(
              label: "添加好友",
            ),
            Gap(getHeight(20)),
            AndroidSearchInput(
                controller: state.searchController,
                hintText: "请输入用户名",
                iconButtonOnTap: () {
                  logic.searchUser();
                }),
            Obx(() {
              if (state.searchLoading.value) {
                return Expanded(
                    child: Column(
                  children: [
                    Gap(getHeight(30)),
                    const SpinKitFadingCircle(
                      color: Colors.black54,
                      size: 60,
                    ),
                  ],
                ));
              }
              if (state.searchEmpty.value && state.searchResult.isEmpty) {
                return Expanded(
                    child: Column(
                  children: [
                    Gap(getHeight(30)),
                    const Text(
                      "该用户不存在",
                      style: AppTexts.defaultStyles,
                    )
                  ],
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                AppAvatar(
                                  name: state.searchResult[position].nickName ??
                                      "空",
                                  image: null,
                                ),
                                Gap(getWidth(5)),
                                Text(
                                  state.searchResult[position].nickName ?? "",
                                  style: AppTexts.defaultStyles,
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                logic.friendApply(state.searchResult[position]);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              child: const Text(
                                "添加好友",
                                style: AppTexts.defaultStyles,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: state.searchResult.length,
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
