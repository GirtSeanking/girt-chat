import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/utils/object_util.dart';

import 'state.dart';

class FriendSearchLogic extends GetxController {
  final FriendSearchState state = FriendSearchState();

  @override
  void onReady() {
    super.onReady();
    initFriendInfoList();
  }

  void initFriendInfoList() async {
    List<UserFriend> res = await state.friendShipService.getFriendList();
    state.friendInfoList.clear();
    state.friendInfoList.addAll(res);
  }

  void searchChanged(String value) async {
    state.showFriendInfoList.clear();
    if (!ObjectUtil.stringIsNotBlank(value)) {
      state.isResult.value = false;
      update(['friendInfoList']);
      return;
    }
    for (int i = 0; i < state.friendInfoList.length; i++) {
      UserFriend item = state.friendInfoList[i];
      if (ObjectUtil.stringIsNotBlank(item.friendRemark)) {
        if (item.friendRemark!.contains(value)) {
          state.showFriendInfoList.add(item);
          continue;
        }
      } else if (ObjectUtil.stringIsNotBlank(item.nickName)) {
        if (item.nickName!.contains(value)) {
          state.showFriendInfoList.add(item);
          continue;
        }
      } else if (ObjectUtil.stringIsNotBlank(item.username)) {
        if (item.username!.contains(value)) {
          state.showFriendInfoList.add(item);
          continue;
        }
      }
    }
    update(['friendInfoList']);
    state.isResult.value = true;
    initFriendInfoList();
  }
}
