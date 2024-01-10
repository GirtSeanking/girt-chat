import 'package:flutter/material.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';

class SendMessageItem extends StatelessWidget {
  final MessageEntity item;
  const SendMessageItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: getWidthByRatio(.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, spreadRadius: .6, blurRadius: 1.2, offset: Offset(0, 1))
                    ]
                  ),
                  child: Text(
                    item.textElem ?? "",
                    style: AppTexts.defaultStyles
                        .copyWith(color: Colors.white),
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
