import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class MySpacePage extends StatelessWidget {
  const MySpacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MySpaceLogic>();
    final state = Get.find<MySpaceLogic>().state;
    final homeState = Get.find<HomeLogic>().state;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: getScreenWidth(),
            height: getHeightByRatio(.3),
            child: Stack(
              children: [
                Lottie.asset(
                  "assets/my/my_space_background_animated.json",
                  width: getScreenWidth(),
                  height: getHeightByRatio(.3),
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: getHeight(40),
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteName.androidSettingPage);
                    },
                    child: const Icon(
                      FluentIcons.list_16_regular,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              logic.pickImage(context);
                            },
                            child: AppAvatar(
                              name: state.nickName.value,
                              image: ObjectUtil.stringIsNotBlank(
                                      state.imageUrl.value)
                                  ? NetworkImage(state.imageUrl.value)
                                  : null,
                              size: 80,
                            ),
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              return Text(
                                state.nickName.value,
                                style: AppTexts.defaultWhiteStyles
                                    .copyWith(fontSize: 20),
                              );
                            }),
                            Gap(getWidth(5)),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteName.androidSetNickName);
                              },
                              child: const Icon(
                                FluentIcons.edit_settings_20_regular,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Gap(getHeight(10)),
                        InkWell(
                          onTap: () {
                            Get.toNamed(RouteName.androidSetSelfSignature);
                          },
                          child: Obx(() {
                            if (ObjectUtil.stringIsNotBlank(
                                state.selfSignature.value)) {
                              return Text(
                                state.selfSignature.value ?? "",
                                style: AppTexts.mediaWhiteStyles,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            } else {
                              return const Text(
                                "介绍一下自己~",
                                style: AppTexts.mediaWhiteStyles,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: getScreenWidth(),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 19,
                  blurRadius: 19,
                )
              ]),
              child: Column(
                children: [
                  Gap(getHeight(40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
