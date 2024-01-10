import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/public/avatar.dart';

class ReceivedMessageItem extends StatelessWidget {
  final MessageEntity item;
  const ReceivedMessageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            name: ObjectUtil.stringIsNotBlank(item.nickName)
                ? item.nickName!
                : item.userID ?? "",
            image: ObjectUtil.stringIsNotBlank(item.faceURL) ? NetworkImage(item.faceURL!) : null,
            size: 50,
          ),
          Gap(getWidth(5)),
          Container(
            constraints: BoxConstraints(maxWidth: getWidthByRatio(.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE8E8EE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, spreadRadius: .6, blurRadius: 1.2, offset: Offset(0, 1))
                      ]
                  ),
                  child: Text(
                    item.textElem ?? "",
                    style: AppTexts.defaultStyles,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    item.timestamp!,
                    style: const TextStyle(color: Colors.black38),
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
