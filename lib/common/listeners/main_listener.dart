import 'package:get/get.dart';
import 'package:girt_chat/pages/android/home/logic.dart';
import 'package:girt_chat/pages/android/my_space/logic.dart';
import 'package:girt_chat/service/user/user_service_impl.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';

class MainListener {
  V2TimSDKListener listener() {
    return V2TimSDKListener(
        onConnectFailed: (int code, String error) {
          print(error);
        },
        onConnectSuccess: () {
          print("连接成功");
        },
        onUserSigExpired: () {
          // 在线时票据过期：此时您需要生成新的 userSig 并再次调用 V2TIMManager 的 login() 函数重新登录。
          final homeState = Get.find<HomeLogic>().state;
          UserService userService = UserService();
          userService.loginIM(homeState.user.value);
        },
        onSelfInfoUpdated: (V2TimUserFullInfo info) {
          // 登录用户的资料发生了更新
          // info登录用户的资料
          try {
            HomeLogic homeLogic = Get.find<HomeLogic>();
            homeLogic.upgradeUserInfo(info);
            MySpaceLogic mySpaceLogic = Get.find<MySpaceLogic>();
            mySpaceLogic.upgradeUserInfo(info);
          } catch (_) {
            rethrow;
          }

        }
    );
  }
}