import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/login_register/register/logic.dart';

class SexUsernameForm extends StatelessWidget {
  const SexUsernameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<RegisterLogic>();
    final state = Get.find<RegisterLogic>().state;

    return SizedBox(
      height: getHeight(280),
      child: Column(
        children: [
          Text(
            "sexChooseLabel".tr,
            style: AppTexts.defaultStyles,
          ),
          Gap(getHeight(15)),
          GetBuilder<RegisterLogic>(
            id: "sexSelect",
            builder: (logic) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      logic.onSexSelected(Constants.manSex);
                    },
                    child: Container(
                      width: getWidth(120),
                      height: getHeight(120),
                      padding: EdgeInsets.all(getHeight(8)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: state.selectedSex.value == Constants.manSex
                                ? AppColors.primaryColor
                                : Colors.black26,
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/sex-choose-man.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      logic.onSexSelected(Constants.womanSex);
                    },
                    child: Container(
                      width: getWidth(120),
                      height: getHeight(120),
                      padding: EdgeInsets.all(getHeight(8)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: state.selectedSex.value == Constants.womanSex
                                ? AppColors.primaryColor
                                : Colors.black26,
                            blurRadius: 2,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        "assets/images/sex-choose-woman.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Gap(getHeight(20)),
          Text(
            "usernameInputLabel".tr,
            style: AppTexts.defaultStyles,
          ),
          Gap(getHeight(20)),
          Container(
            width: getWidth(220),
            height: getHeight(50),
            padding: EdgeInsets.all(getWidth(10)),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54, width: 2),
                borderRadius: BorderRadius.circular(getHeight(8))),
            child: TextField(
              controller: state.usernameController,
              decoration: const InputDecoration(
                  border: InputBorder.none, counterText: ""),
              cursorColor: AppColors.primaryColor,
              textAlign: TextAlign.center,
              maxLength: 12,
            ),
          ),

        ],
      ),
    );
  }
}
