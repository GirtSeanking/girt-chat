import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/date_util.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/friend/friend_info/widgets/online_state.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:girt_chat/pages/public/sex_show.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class FriendInfoPage extends StatelessWidget {
  const FriendInfoPage({Key? key}) : super(key: key);

  final String indentFirstLineOfText = "        ";

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FriendInfoLogic>();
    final state = Get.find<FriendInfoLogic>().state;

    return AndroidBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AndroidPageHead(
            dropdownItems: const [
              DropdownMenuItem(value: "setRemark", child: Text("设置备注"))
            ],
            onChanged: (value) {
              logic.handleMenuSelected(value.toString(), context);
            },
            dropdownWidth: getWidth(100),
          ),
          GetBuilder<FriendInfoLogic>(
            id: "userInfo",
            builder: (logic) {
              UserFriend user = state.currentUserFriend.value;
              if (state.userInfoLoading.value) {
                return Container();
              } else {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: "chat-user-avatar",
                          child: Material(
                            type: MaterialType.transparency,
                            child: AppAvatar(
                              name: ObjectUtil.stringIsNotBlank(
                                      user.friendRemark)
                                  ? user.friendRemark!
                                  : ObjectUtil.stringIsNotBlank(user.nickName)
                                      ? user.nickName!
                                      : user.username ?? "",
                              image: ObjectUtil.stringIsNotBlank(
                                  user.photoUrl)
                                  ? NetworkImage(user.photoUrl!)
                                  : null,
                              size: 80,
                            ),
                          ),
                        ),
                        Gap(getWidth(10)),
                        Column(
                          children: [
                            SizedBox(
                              width: getWidthByRatio(.6),
                              child: Row(
                                children: [
                                  Hero(
                                    tag: "chat-user-name",
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: getWidthByRatio(.6) - 25),
                                        child: Text(
                                          ObjectUtil.stringIsNotBlank(
                                                  user.friendRemark)
                                              ? user.friendRemark!
                                              : ObjectUtil.stringIsNotBlank(
                                                      user.nickName)
                                                  ? user.nickName!
                                                  : user.username ?? "",
                                          style: AppTexts.bigStyles,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(getWidth(2)),
                                  AppSexShow(
                                    sex: int.parse(
                                        state.currentUserFriend.value.sex ??
                                            "0"),
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: getWidthByRatio(.6),
                              child: Row(
                                children: [
                                  Text("账号:${user.username}"),
                                  Gap(getWidth(10)),
                                  Text(
                                      "年龄:${DateUtil.calAge(int.parse(user.birthday!))}"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: getWidthByRatio(.6),
                              child: OnlineState(
                                androidOnline: user.androidOnline ?? false,
                                windowsOnline: user.windowOnline ?? false,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Gap(getHeight(10)),
                    if (!ObjectUtil.stringIsNotBlank(user.selfSignature))
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText(
                          "$indentFirstLineOfText为君沉醉又何妨，只怕酒醒时候断人肠。",
                          maxLines: 4,
                          style: AppTexts.defaultStyles,
                        ),
                      ),
                  ],
                );
              }
            },
          ),
          Gap(getHeight(20)),
          Expanded(
              child: Container(
            width: getScreenWidth(),
            color: Colors.grey[200]!,
            child: Stack(
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/list/list_empty_emoji_animated.json",
                    height: getHeight(200),
                    width: getWidth(200),
                  ),
                ),
                Positioned(
                  bottom: getHeight(20),
                  left: getWidthByRatio(.5) - getWidth(65),
                  child: AppButton.primary(
                      text: "发消息",
                      onPressed: () {
                        logic.jumpToChatPage();
                      }),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
