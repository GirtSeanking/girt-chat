import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class SetBirthDayState {
  UserService userService = UserService();
  Rx<UserVo> currentUser = Rx(UserVo());

  RxList<int> years = <int>[].obs;
  RxList<int> months = <int>[].obs;
  RxList<int> days = <int>[].obs;

  int selectedYearIndex = 0;
  int selectedMonthIndex = 0;
  int selectedDayIndex = 0;

  ScrollController yearScrollController = ScrollController();
  ScrollController monthScrollController = ScrollController();
  ScrollController dayScrollController = ScrollController();

  double temp = -10.0;

  RxDouble btnOpacity = 0.0.obs;
}
