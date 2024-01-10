import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/android/message_list/logic.dart';
import 'package:girt_chat/pages/public/avatar.dart';
import 'package:girt_chat/pages/public/badge_box.dart';

class ConversationItem extends StatelessWidget {
  final ConversationEntity item;
  const ConversationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<MessageListLogic>();
    final homeState = Get.find<HomeLogic>().state;
    return InkWell(
      onTap: () {
        logic.openChatPage(item);
      },
      child: Container(
        height: getHeight(80),
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
        ),
        child: Row(
          children: [
            AppBadgeBox(
              count: item.unreadCount!,
              child: AppAvatar(
                name: item.showName ?? "",
                image: ObjectUtil.stringIsNotBlank(item.faceUrl) ? NetworkImage(item.faceUrl!) : null,
                size: 60,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 10,
                ),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black12, width: .6))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.showName ?? "",
                          style: AppTexts.defaultStyles.copyWith(fontSize: 17),
                        ),
                        LayoutBuilder(builder: (context, constraints) {
                          if (ObjectUtil.stringIsNotBlank(item.draftText)) {
                            return Text(item.draftTimestamp!);
                          } else if (item.lastMessage != null) {
                            return Text(item.lastMessage!.timestamp ?? "");
                          } else {
                            return Container();
                          }
                        })
                      ],
                    ),
                    Gap(getWidth(4)),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (ObjectUtil.stringIsNotBlank(item.draftText)) {
                          return Row(
                            children: [
                              const Icon(
                                FluentIcons.edit_12_filled,
                                size: 16,
                                color: Color(0xFFFA800C),
                              ),
                              Gap(getWidth(4)),
                              Expanded(
                                child: Text(
                                  item.draftText ?? "",
                                  style: AppTexts.defaultStyles.copyWith(
                                      fontSize: 12, color: Colors.black54),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        } else if (item.lastMessage!.msgID != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: getWidthByRatio(.55),
                                child: Text(
                                  item.lastMessage!.textElem!,
                                  style: AppTexts.defaultStyles.copyWith(
                                      fontSize: 12, color: Colors.black54),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (!item.lastMessage!.isPeerRead! &&
                                  item.lastMessage!.userID ==
                                      homeState.user.value.username)
                                Expanded(
                                  child: Container(
                                    width: getWidth(10),
                                    height: getHeight(10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFD32F2F),
                                    ),
                                  ),
                                )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
