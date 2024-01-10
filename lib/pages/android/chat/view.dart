import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/conversation/conversation_entity.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/chat/widgets/received_message_item.dart';
import 'package:girt_chat/pages/android/chat/widgets/send_message_item.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/public/avatar.dart';

import 'logic.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ChatLogic>();
    final state = Get.find<ChatLogic>().state;
    final homeState = Get.find<HomeLogic>().state;
    if (Get.arguments is ConversationEntity) {
      state.currentConversation.value = Get.arguments;
    }

    return AndroidBackground(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(FluentIcons.ios_arrow_24_filled),
                ),
                Hero(
                  tag: "chat-user-avatar",
                  child: Material(
                    type: MaterialType.transparency,
                    child: AppAvatar(
                      name: ObjectUtil.stringIsNotBlank(
                              state.currentConversation.value.showName)
                          ? state.currentConversation.value.showName!
                          : state.currentConversation.value.userID ?? "",
                      image: ObjectUtil.stringIsNotBlank(state.currentConversation.value.faceUrl) ? NetworkImage(state.currentConversation.value.faceUrl!) : null,
                      size: 60,
                    ),
                  ),
                ),
                Gap(getWidth(5)),
                Hero(
                  tag: "chat-user-name",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      ObjectUtil.stringIsNotBlank(
                              state.currentConversation.value.showName)
                          ? state.currentConversation.value.showName!
                          : state.currentConversation.value.userID ?? "",
                      style: AppTexts.defaultStyles.copyWith(fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [GestureDetector(
                      onTap: () {
                        logic.jumpToFriendInfo();
                      },
                      child: Icon(FluentIcons.list_16_regular))],
                ))
              ],
            ),
          ),
          Obx(
            () {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListView.builder(
                    controller: state.chatListScrollController,
                    reverse: true,
                    itemBuilder: (context, position) {
                      MessageEntity item = state.historyMessage[position];
                      if (item.sender == homeState.user.value.username) {
                        return SendMessageItem(item: item);
                        // return SendMessageItem(item: item);
                      } else {
                        return ReceivedMessageItem(item: item);
                      }
                    },
                    itemCount: state.historyMessage.length,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  ),
                ),
              );
            },
          ),
          Container(
            height: getHeight(80),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6.0,
                  offset: Offset(0, -3),
                ),
              ],
            ),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: TextField(
                      controller: state.msgController,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        hintText: "输入新消息",
                        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
                        contentPadding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.primaryColor.withOpacity(0.1),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: getWidth(45),
                  height: getHeight(45),
                  margin: const EdgeInsets.only(right: 8, top: 8),
                  child: RawMaterialButton(
                    fillColor: AppColors.primaryColor,
                    shape: const CircleBorder(),
                    elevation: 5.0,
                    child: const Icon(
                      FluentIcons.send_16_filled,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      logic.sendMessage(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
