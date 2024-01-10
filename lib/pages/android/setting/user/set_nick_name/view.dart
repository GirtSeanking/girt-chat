import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';

import 'logic.dart';

class SetNickNamePage extends StatelessWidget {
  const SetNickNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SetNickNameLogic>();
    final state = Get.find<SetNickNameLogic>().state;
    final homeState = Get.find<HomeLogic>().state;

    return AndroidBackground(
      child: Column(
        children: [
          AndroidPageHead(
            label: "设置昵称",
            onBack: () {
              logic.back(context);
            },
            buttonText: "保存",
            buttonOnClick: () {
              logic.saveNewNickName();
            },
          ),
          Gap(getHeight(10)),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                Expanded(child: Obx(() {
                  return TextField(
                    autofocus: true,
                    controller: state.inputController,
                    maxLength: 15,
                    onChanged: logic.inputChanged,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        constraints: const BoxConstraints(maxHeight: 35),
                        hintText: state.hintText.value,
                        counterText: "",
                        contentPadding: const EdgeInsets.only(bottom: 12)),
                    cursorColor: AppColors.primaryColor,
                  );
                })),
                Obx(() {
                  return Text(
                    "${state.textLength.value} / 15",
                    style: AppTexts.greyStyles,
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
