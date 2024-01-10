import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class SetNickNameState {
  UserService userService = UserService();
  TextEditingController inputController = TextEditingController();

  String oldNickName = "";

  RxString hintText = "".obs;

  RxInt textLength = 0.obs;

  String newNickName = "";
}
