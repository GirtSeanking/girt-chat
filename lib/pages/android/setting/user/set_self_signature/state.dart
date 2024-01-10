import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';

class SetSelfSignatureState {
  UserService userService = UserService();
  TextEditingController inputController = TextEditingController();

  String oldSelfSignature = "";

  RxString hintText = "".obs;

  String newSelfSignature = "";
}
