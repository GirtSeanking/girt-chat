import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/android/public/background.dart';
import 'package:girt_chat/pages/android/public/page_head.dart';

import 'logic.dart';

class SetSelfSignaturePage extends StatelessWidget {
  const SetSelfSignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SetSelfSignatureLogic>();
    final state = Get
        .find<SetSelfSignatureLogic>()
        .state;

    return AndroidBackground(
      child: Column(
        children: [
          AndroidPageHead(
            label: "设置签名",
            onBack: () {
              logic.back(context);
            },
            buttonText: "保存",
            buttonOnClick: () {
              logic.saveNewSelfSignature();
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
            child: Obx(() {
              return TextField(
                autofocus: true,
                controller: state.inputController,
                maxLength: 50,
                onChanged: logic.inputChanged,
                maxLines: null,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: state.hintText.value
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
