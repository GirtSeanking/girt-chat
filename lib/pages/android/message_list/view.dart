import 'package:date_format/date_format.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/android/message_list/widgets/conversation_item.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/search_input.dart';
import 'package:girt_chat/pages/android/public/search_input_btn.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/badge_box.dart';

import 'logic.dart';

class MessageListPage extends StatelessWidget {
  const MessageListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MessageListLogic>();
    final state = Get.find<MessageListLogic>().state;
    final homeState = Get.find<HomeLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Row(
                    children: [
                      AppAvatar(
                        name: homeState.user.value.nickName ?? "空",
                        image: ObjectUtil.stringIsNotBlank(homeState.user.value.photoUrl) ? NetworkImage(homeState.user.value.photoUrl!) : null,
                      ),
                    ],
                  );
                }),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.androidFriendList);
                      },
                      child: const Icon(FluentIcons.people_16_filled),
                    ),
                    Gap(getWidth(20)),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName.androidFriendApplyList);
                        },
                        child: AppBadgeBox(
                          count: state.friendApplicationUnread.value,
                          child: const Icon(
                              FluentIcons.people_checkmark_16_regular),
                        ),
                      );
                    }),
                    Gap(getWidth(20)),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.androidNewFriendSearch);
                      },
                      child: const Icon(FluentIcons.add_16_regular),
                    ),
                  ],
                )
              ],
            ),
          ),
          Gap(getHeight(5)),
          const AndroidSearchInputBtn(),
          Gap(getHeight(5)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Obx(() {
                return ListView.builder(
                  itemBuilder: (context, position) {
                    ConversationEntity item = state.conversationList[position];
                    return ConversationItem(item: item);
                  },
                  itemCount: state.conversationList.length,
                  padding: const EdgeInsets.all(8),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
