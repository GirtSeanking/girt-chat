import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/entities/user/user_friend.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/android/friend/friend_list/state.dart';
import 'package:tencent_im_sdk_plugin_platform_interface/models/v2_tim_friend_info.dart';

class FriendListLogic extends GetxController {
  final FriendListState state = FriendListState();

  @override
  void onReady() {
    getFriendInfoList();
    addScrollListener();
    super.onReady();
  }

  void getFriendInfoList() async {
    List<UserFriend> res = await state.friendShipService.getFriendList();
    if (res.isNotEmpty) {
      state.friendList.addAll(res);
    }
    convertMap();
  }

  void convertMap() {
    state.contractMap.clear();
    for (String letter in state.az) {
      for (UserFriend item in state.friendList) {
        if (letter == item.firstLetter) {
          if (state.contractMap.containsKey(letter)) {
            state.contractMap[letter]!.add(item);
          } else {
            state.contractMap.addIf(
                () => !state.contractMap.containsKey(letter), letter, [item]);
          }
        }
      }
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      state.indexShow.value =
          state.pageViewScrollController.position.maxScrollExtent >
              getHeightByRatio(.7);
    });
  }

  // 添加界面滚动监听
  void addScrollListener() {
    state.pageViewScrollController.addListener(() {
      for (int i = 0; i < state.contractMap.keys.length; i++) {
        Offset offset = const Offset(0, 0);
        offset = (Get.keys[state.contractMap.keys.toList()[i]]!.currentContext!
                .findRenderObject() as RenderBox)
            .localToGlobal(offset);
        if (offset.dy.toInt() <= 42) {
          state.selectedIndex.value = i;
        } else {
          if (i == 0) {
            state.selectedIndex.value = Constants.unSelected;
          }
          break;
        }
      }
    });
  }

  // 索引列表点击事件
  void onDragDown(DragDownDetails details) {
    int i = details.localPosition.dy ~/ 19;
    state.selectedIndex.value = i;
    state.bubbleShow.value = true;
    scrollTo(i);
  }

  void onDragUpdate(DragUpdateDetails details) {
    int i = details.localPosition.dy ~/ 19;
    state.selectedIndex.value = i;
    state.bubbleShow.value = true;
    scrollTo(i);
  }

  void onDragEnd(DragEndDetails details) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      state.bubbleShow.value = false;
    });
  }

  // 联系人列表跳转
  void scrollTo(int index) {
    if (state.indexShow.value) {
      Offset offset = const Offset(0, 0);
      offset = (Get
              .keys[state.contractMap.keys.toList()[index]]!.currentContext!
              .findRenderObject() as RenderBox)
          .localToGlobal(offset);
      if (offset.dy > 0) {
        double currentPixels =
            state.pageViewScrollController.position.pixels - 40;
        state.pageViewScrollController.jumpTo(currentPixels + offset.dy);
      } else {
        double currentPixels =
            state.pageViewScrollController.position.pixels - 40;
        state.pageViewScrollController.jumpTo(currentPixels + offset.dy);
      }
    }
  }

  void jumpToFriendInfoPage(UserFriend userFriend) {
    Get.toNamed(RouteName.androidFriendInfo, arguments: userFriend);
  }

  void upgradeFriendList(List<V2TimFriendInfo> infoList) {
    List<UserFriend> tempList = [];
    tempList.addAll(state.friendList);
    for (V2TimFriendInfo vtItem in infoList) {
      for (UserFriend element in tempList) {
        if (element.username! == vtItem.userID) {
          element.friendRemark = vtItem.friendRemark ?? "";
        }
      }
    }
    state.friendList.clear();
    state.friendList.addAll(tempList);
    convertMap();
  }
}
