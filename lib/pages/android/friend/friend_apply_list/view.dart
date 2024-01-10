import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';
import 'package:girt_chat/pages/android/public/search_input.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/buttons.dart';

import 'logic.dart';

class FriendApplyListPage extends StatelessWidget {
  const FriendApplyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FriendApplyListLogic>();
    final state = Get.find<FriendApplyListLogic>().state;

    return Scaffold(
      body: AndroidBackground(
        child: Column(
          children: [
            const AndroidPageHead(
              label: "好友申请",
            ),
            Gap(getHeight(20)),
            AndroidSearchInput(
                controller: state.searchController,
                hintText: "请输入用户名或昵称",
                iconButtonOnTap: () {
                  logic.searchApplicationUser();
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
              } else if (state.searchResult.isEmpty) {
                return Expanded(
                    child: Column(
                  children: [
                    Gap(getHeight(30)),
                    const Text(
                      "暂无申请信息",
                      style: AppTexts.defaultStyles,
                    )
                  ],
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -30,
                              right: -10,
                              child: Container(
                                width: getWidth(80),
                                height: getHeight(80),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF7C09D),
                                      Color(0xFFDB89DF)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 30,
                              child: Container(
                                width: getWidth(50),
                                height: getHeight(50),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFB1B7ED),
                                      Color(0xFFEB8995)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      AppAvatar(
                                        name: ObjectUtil.stringIsNotBlank(state
                                                .searchResult[position]
                                                .nickName)
                                            ? state.searchResult[position]
                                                .nickName!
                                            : "空",
                                        image: ObjectUtil.stringIsNotBlank(state
                                                .searchResult[position]
                                                .photoUrl)
                                            ? NetworkImage(state
                                                .searchResult[position]
                                                .photoUrl!)
                                            : null,
                                        size: 70,
                                      ),
                                      Gap(getWidth(5)),
                                      Text(
                                        ObjectUtil.stringIsNotBlank(state
                                                .searchResult[position]
                                                .nickName)
                                            ? state.searchResult[position]
                                                .nickName!
                                            : state.searchResult[position]
                                                    .username ??
                                                "",
                                        style: AppTexts.defaultStyles
                                            .copyWith(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Gap(getHeight(20)),
                                  Row(
                                    children: [
                                      const Text(
                                        "验证消息：",
                                        style: AppTexts.defaultStyles,
                                      ),
                                      Gap(getHeight(5)),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        width: getWidth(240),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.searchResult[position]
                                                    .addWording ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(getHeight(20)),
                                  Center(
                                    child: AppButton(
                                      text: "添加好友",
                                      onPressed: () {
                                        logic.onAddFriendBtnClick(
                                            state.searchResult[position]);
                                      },
                                      bgColor: AppColors.primaryColor,
                                      textColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
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
