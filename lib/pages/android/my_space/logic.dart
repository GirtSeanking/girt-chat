import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';

import 'state.dart';

class MySpaceLogic extends GetxController {
  final MySpaceState state = MySpaceState();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  void logout() async {
    await state.userService.logout();
    Get.offNamed(RouteName.login);
  }

  void initData() {
    final homeState = Get.find<HomeLogic>().state;
    state.nickName.value =
        ObjectUtil.stringIsNotBlank(homeState.user.value.nickName)
            ? homeState.user.value.nickName!
            : homeState.user.value.username ?? "";
    state.selfSignature.value = homeState.user.value.selfSignature ?? "";
    state.imageUrl.value = homeState.user.value.photoUrl ?? "";
  }

  // 更新用户信息
  void upgradeUserInfo(V2TimUserFullInfo info) {
    state.nickName.value = ObjectUtil.stringIsNotBlank(info.nickName)
        ? info.nickName!
        : info.userID ?? "";
    state.selfSignature.value = info.selfSignature ?? "";
    state.imageUrl.value = info.faceUrl ?? "";
  }

  void pickImage(BuildContext context) async {
    Dialogs.bottomMaterialDialog(
      context: context,
      customView: Column(
        children: [
          AppButton(
            text: "拍照",
            onPressed: () {
              state.userService.saveAvatar(ImageSource.camera);
              Get.back();
            },
            width: getWidthByRatio(.9),
          ),
          Gap(getHeight(10)),
          AppButton(
            text: "从手机相册选择",
            onPressed: () {
              state.userService.saveAvatar(ImageSource.gallery);
              Get.back();
            },
            width: getWidthByRatio(.9),
          )
        ],
      ),
      color: Colors.transparent,
    );
  }
}
