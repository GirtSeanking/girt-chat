import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_apply.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:girt_chat/common/utils/toast_util.dart';

import 'state.dart';

class FriendApplyListLogic extends GetxController {
  final FriendApplyListState state = FriendApplyListState();


  @override
  void onReady() {
    applicationListInit();
    setFriendApplicationRead();
    super.onReady();
  }

  // 申请列表初始化
  void applicationListInit() async {
    state.searchLoading.value = true;
    var res = await state.friendShipService.getFriendApplicationList();
    for (int i = 0; i < res['list'].length; i ++) {
      UserApply item = UserApply.fromV2TimFriendApplication(res['list'][i]);
      state.searchResult.add(item);
    }
    state.searchLoading.value = false;
  }

  // 申请列表已读
  void setFriendApplicationRead() {
    state.friendShipService.setFriendApplicationRead();
  }

  // 搜索申请列表
  void searchApplicationUser() {
    if (state.searchController.text.isEmpty) {
      applicationListInit();
    } else {
      state.searchLoading.value = true;
      List<UserApply> temp = [];
      List<UserApply> res = [];
      temp.addAll(state.searchResult);
      state.searchResult.clear();
      for (var value in temp) {
        if (ObjectUtil.stringIsNotBlank(value.nickName)) {
          if (value.nickName!.contains(state.searchController.text)) {
            res.add(value);
            continue;
          }
        }
        if (ObjectUtil.stringIsNotBlank(value.username)) {
          if (value.username!.contains(state.searchController.text)) {
            res.add(value);
          }
        }
      }
      state.searchResult.addAll(res);
      state.searchEmpty.value = state.searchResult.isEmpty;
      state.searchLoading.value = false;
    }
  }

  // 好友添加
  void onAddFriendBtnClick(UserApply userApply) async {
    bool res = await state.friendShipService.acceptFriendApplication(userApply);
    if (res) {
      state.searchResult.remove(userApply);
    } else {
      ToastUtil.errorToast("添加好友失败");
    }
  }
}
