import 'package:get/get.dart';
import 'package:girt_chat/common/entities/message/message_entity.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/service/im_service.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_user_full_info.dart';
import 'state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  @override
  void onReady() {
    getCurrentUser();
    super.onReady();
  }

  // 获取当前用户信息
  void getCurrentUser() async {
    state.user.value = await state.userService.getCurrentUser() ?? UserVo();
    registerIMListener();
    if (!ObjectUtil.stringIsNotBlank(state.user.value.birthday)) {
      Get.toNamed(RouteName.androidSetBirthday, arguments: state.user.value);
    }
  }

  // tab栏页码切换
  void handlePageChanged(int page) {
    state.page.value = page;
    state.pageController.jumpToPage(page);
  }

  // 注册IM监听器
  void registerIMListener() async {
    // 创建消息监听
    IMService.to.createMessageListener();
    // 创建好友申请监听
    IMService.to.createFriendApplyListener();
    // 创建会话监听
    IMService.to.createConversationListener();
  }

  // 消息界面消息未读数增加
  void messageUnreadAdd(int value) {
    state.messageListUnread.value += value;
  }

  // 消息界面消息未读数减少
  void messageUnreadSub(int value) {
    state.messageListUnread.value -= value;
  }

  // 更新保存的用户信息
  void upgradeUserInfo(V2TimUserFullInfo info) {
    state.user.value.upgradeUserFullInfo(info);
  }
}
