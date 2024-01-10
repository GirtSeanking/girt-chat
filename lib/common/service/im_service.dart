import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/listeners/advanced_msg_listener.dart';
import 'package:girt_chat/common/listeners/conversation_listener.dart';
import 'package:girt_chat/common/listeners/friendship_listener.dart';
import 'package:girt_chat/common/listeners/main_listener.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimConversationListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimFriendshipListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';

class IMService extends GetxService {
  static IMService get to => Get.find();

  Future<void> init() async {
    V2TimSDKListener sdkListener = MainListener().listener();
    // 3.初始化SDK
    V2TimValueCallback<bool> initSDKRes =
        await TencentImSDKPlugin.v2TIMManager.initSDK(
      sdkAppID: Constants.sdkAppId, // SDKAppID
      loglevel: LogLevelEnum.V2TIM_LOG_ALL, // 日志登记等级
      listener: sdkListener, // 事件监听器
    );
    if (initSDKRes.code == 0) {
      LogService.to.log("初始化成功");
    }
  }

  // 创建消息监听
  void createMessageListener() {
    V2TimAdvancedMsgListener listener = AdvancedMsgListener().listener();
    TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .addAdvancedMsgListener(listener: listener);
  }

  // 创建会话监听
  void createConversationListener() {
    V2TimConversationListener listener = ConversationListener().listener();
    TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .addConversationListener(listener: listener);
  }

  // 创建好友监听
  void createFriendApplyListener() {
    V2TimFriendshipListener listener = FriendshipListener().listener();
    TencentImSDKPlugin.v2TIMManager
        .getFriendshipManager()
        .setFriendListener(listener: listener);
  }
}
