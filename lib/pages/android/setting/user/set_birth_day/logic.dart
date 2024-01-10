import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/utils/date_util.dart';

import 'state.dart';

class SetBirthDayLogic extends GetxController {
  final SetBirthDayState state = SetBirthDayState();

  @override
  void onReady() {
    initPageData();
    super.onReady();
  }

  void initPageData() {
    state.years.addAll(DateUtil.getYears());
    state.selectedYearIndex = state.years.indexOf(DateTime.now().year);
    state.months.addAll(DateUtil.getMonths());
    state.selectedMonthIndex = state.months.indexOf(DateTime.now().month);
    resetDays();
    state.selectedDayIndex = state.days.indexOf(DateTime.now().day);
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollTo();
      state.btnOpacity.value = 1;
    });
  }

  void scrollMethod(ScrollNotification notification, String type) {
    double currentPixels = notification.metrics.pixels;
    int index = (currentPixels + 10) ~/ 30;
    if (notification is ScrollUpdateNotification) {
      if (type == "year") {
        setYearIndex(index);
      } else if (type == "month") {
        setMonthIndex(index);
      } else if (type == "day") {
        setDayIndex(index);
      }
    } else if (notification is ScrollEndNotification) {
      if (state.temp < 0) {
        state.temp = (30 * index).toDouble();
        if (type == "year") {
          state.yearScrollController.jumpTo(
            (30 * index).toDouble(),);
        } else if (type == "month") {
          state.monthScrollController.jumpTo((30 * index).toDouble());
        } else if (type == "day") {
          state.dayScrollController.jumpTo((30 * index).toDouble());
        }

      } else {
        if (state.temp == currentPixels) {
          state.temp = -10.0;
        }
      }
    }
  }

  void setYearIndex(int index) {
    state.selectedYearIndex = index;
    resetDays();
  }

  void setMonthIndex(int index) {
    state.selectedMonthIndex = index;
    resetDays();
  }

  void resetDays() {
    state.days.clear();
    state.days.addAll(DateUtil.getDays(state.years[state.selectedYearIndex],
        state.months[state.selectedMonthIndex]));
  }

  void setDayIndex(int index) {
    state.selectedDayIndex = index;
  }

  void scrollTo() {
    state.yearScrollController.animateTo(
        (30 * state.selectedYearIndex).toDouble(),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutQuart);
    state.monthScrollController.animateTo(
        (30 * state.selectedMonthIndex).toDouble(),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutQuart);
    state.dayScrollController.animateTo(
        (30 * state.selectedDayIndex).toDouble(),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutQuart);
  }

  void setBirthDay() async {
    DateTime paramDate = DateTime(
        state.years[state.selectedYearIndex],
        state.months[state.selectedMonthIndex],
        state.days[state.selectedDayIndex]);
    String paramTimestamp =
        (paramDate.millisecondsSinceEpoch / 1000).ceil().toString();
    await state.userService.updateUserBirthday(paramTimestamp);
    Get.back();
  }
}
