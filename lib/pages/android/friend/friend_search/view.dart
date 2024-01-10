import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class FriendSearchPage extends StatelessWidget {
  const FriendSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FriendSearchLogic>();
    final state = Get.find<FriendSearchLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Hero(
                tag: "search-input",
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          FluentIcons.search_16_regular,
                          color: Color(0xFF666666),
                        ),
                        Expanded(
                          child: TextField(
                            controller: state.searchController,
                            onChanged: logic.searchChanged,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              constraints: BoxConstraints(maxHeight: 80),
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: "搜索",
                            ),
                            cursorColor: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "取消",
                    style: AppTexts.defaultPrimaryStyles.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GetBuilder<FriendSearchLogic>(
                id: "friendInfoList",
                builder: (logic) {
                  if (state.showFriendInfoList.isEmpty &&
                      !state.isResult.value) {
                    return Center(
                      child: Lottie.asset(
                          "assets/friend/friend_search_show_animated.json"),
                    );
                  } else if (state.showFriendInfoList.isEmpty &&
                      state.isResult.value) {
                    return const Center(
                      child: Text(
                        "该好友不存在",
                        style: AppTexts.defaultStyles,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemBuilder: (ctx, index) {
                        UserFriend friend = state.showFriendInfoList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                )
                              ]),
                          child: Row(
                            children: [
                              AppAvatar(
                                name: ObjectUtil.stringIsNotBlank(
                                        friend.friendRemark)
                                    ? friend.friendRemark!
                                    : ObjectUtil.stringIsNotBlank(
                                            friend.nickName)
                                        ? friend.nickName!
                                        : friend.username ?? "",
                                image: ObjectUtil.stringIsNotBlank(friend.photoUrl) ? NetworkImage(friend.photoUrl!) : null,
                                size: 50,
                              ),
                              Gap(getWidth(10)),
                              Text(
                                ObjectUtil.stringIsNotBlank(friend.friendRemark)
                                    ? friend.friendRemark!
                                    : ObjectUtil.stringIsNotBlank(
                                            friend.nickName)
                                        ? friend.nickName!
                                        : friend.username ?? "",
                                style: AppTexts.defaultStyles,
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: state.showFriendInfoList.length,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
