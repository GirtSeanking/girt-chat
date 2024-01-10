import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/friend/new_friend_search/logic.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/buttons.dart';

class FriendApplyPage extends StatelessWidget {
  const FriendApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<NewFriendSearchLogic>();
    final state = Get.find<NewFriendSearchLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          const AndroidPageHead(label: "发送好友验证",),
          Gap(getHeight(20)),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 2)
                ]),
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
                        colors: [Color(0xFFF7C09D), Color(0xFFDB89DF)],
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
                        colors: [Color(0xFFB1B7ED), Color(0xFFEB8995)],
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AppAvatar(
                              name: state.userApply.nickName ?? "空",
                              image: ObjectUtil.stringIsNotBlank(
                                  state.userApply.photoUrl)
                                  ? NetworkImage(state.userApply.photoUrl!)
                                  : null,
                              size: 80,
                            ),
                            Gap(getWidth(10)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      state.userApply.nickName ?? "",
                                      style: AppTexts.defaultStyles
                                          .copyWith(fontSize: 25),
                                    ),
                                    Gap(getWidth(5)),
                                    LayoutBuilder(
                                        builder: (context, constraint) {
                                      if (state.userApply.sex ==
                                          Constants.manSex.toString()) {
                                        return Image.asset(
                                          "assets/images/boy.png",
                                          width: getWidth(20),
                                          height: getHeight(20),
                                        );
                                      } else if (state.userApply.sex ==
                                          Constants.womanSex.toString()) {
                                        return Image.asset(
                                          "assets/images/girl.png",
                                          width: getWidth(20),
                                          height: getHeight(20),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    })
                                  ],
                                ),
                                Text(
                                  state.userApply.username ?? "",
                                  style: AppTexts.greyStyles,
                                )
                              ],
                            )
                          ],
                        ),
                        Gap(getHeight(20)),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: state.remarkController,
                            cursorColor: AppColors.primaryColor,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "设置备注",
                            ),
                          ),
                        ),
                        Gap(getHeight(20)),
                        const Row(
                          children: [
                            Text(
                              "验证消息",
                              style: AppTexts.defaultStyles,
                            )
                          ],
                        ),
                        Gap(getHeight(5)),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: state.applyWordingController,
                            maxLength: 200,
                            maxLines: null,
                            cursorColor: AppColors.primaryColor,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Gap(getHeight(20)),
                        AppButton(
                          text: "发送请求",
                          onPressed: () {
                            logic.sendFriendApply();
                          },
                          bgColor: AppColors.primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
