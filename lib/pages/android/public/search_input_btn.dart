import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';

class AndroidSearchInputBtn extends StatelessWidget {
  const AndroidSearchInputBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteName.androidFriendSearch);
      },
      child: Hero(
        tag: "search-input",
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: getWidthByRatio(.7),
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FluentIcons.search_16_regular,
                  color: Color(0xFF666666),
                ),
                Text(
                  "搜索",
                  style: AppTexts.greyStyles,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
