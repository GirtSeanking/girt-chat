import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:lottie/lottie.dart';

import 'logic.dart';

class SetBirthDayPage extends StatelessWidget {
  const SetBirthDayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<SetBirthDayLogic>();
    final state = Get
        .find<SetBirthDayLogic>()
        .state;
    if (Get.arguments is UserVo) {
      state.currentUser.value = Get.arguments;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/set/set_birthday_animated.json",
            width: getScreenWidth(),
            height: getScreenWidth(),
            repeat: false,
          ),
          Text(
            "你的生日",
            style: AppTexts.bigStyles.copyWith(
                fontWeight: FontWeight.w600, fontFamily: "SanFrancisco"),
          ),
          Gap(getHeight(10)),
          Obx(() {
            if (state.years.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getHeight(120),
                    width: getWidth(100),
                    child: NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        logic.scrollMethod(notification, "year");
                        return false;
                      },
                      child: ListWheelScrollView(
                          controller: state.yearScrollController,
                          itemExtent: 30,
                          offAxisFraction: -.1,
                          overAndUnderCenterOpacity: .4,
                          children: state.years
                              .map((element) =>
                              Text(
                                "$element年",
                                style: AppTexts.defaultStyles,
                              ))
                              .toList()),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(120),
                    width: getWidth(100),
                    child: NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        logic.scrollMethod(notification, "month");
                        return false;
                      },
                      child: ListWheelScrollView(
                          controller: state.monthScrollController,
                          itemExtent: 30,
                          overAndUnderCenterOpacity: .4,
                          children: state.months
                              .map((element) =>
                              Text(
                                "$element月",
                                style: AppTexts.defaultStyles,
                              ))
                              .toList()),
                    ),
                  ),
                  SizedBox(
                    height: getHeight(120),
                    width: getWidth(100),
                    child: NotificationListener(
                      onNotification: (ScrollNotification notification) {
                        logic.scrollMethod(notification, "day");
                        return false;
                      },
                      child: ListWheelScrollView(
                          controller: state.dayScrollController,
                          itemExtent: 30,
                          offAxisFraction: .1,
                          overAndUnderCenterOpacity: .4,
                          children: state.days
                              .map((element) =>
                              Text(
                                "$element日",
                                style: AppTexts.defaultStyles,
                              ))
                              .toList()),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
          Gap(getHeight(10)),
          Obx(() {
            return AnimatedOpacity(
              opacity: state.btnOpacity.value,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutQuart,
              child: AppButton(
                text: "确认",
                onPressed: () {
                  logic.setBirthDay();
                },
                bgColor: AppColors.primaryColor,
                textColor: Colors.white,
              ),
            );
          })
        ],
      ),
    );
  }
}
