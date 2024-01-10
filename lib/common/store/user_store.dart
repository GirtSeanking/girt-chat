import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:girt_chat/common/service/storage_service.dart';

/// 用户信息存储
class UserStore {
  // 保存用户列表 信息key,length
  static const String key = "user-list";
  static const String length = "user-list-length";

  // 删除本地用户
  void delUser(UserVo user) async {
    List<UserVo> list = await getList();
    int index = userAt(list, user);
    list.removeAt(index);
    saveList(list);
  }

  // 保存用户至本地
  saveUser(UserVo user) async {
    log("保存用户");
    List<UserVo> list = await getList();
    list = addNoRepeat(list, user);
    saveList(list);
  }

  // 去重
  addNoRepeat(List<UserVo> list, UserVo user) {
    int index = userAt(list, user);
    if (index != -1) {
      list.removeAt(index);
    }
    list.insert(0, user);
    return list;
  }

  // 获取用户在列表里存在的位置
  int userAt(List<UserVo> list, UserVo user) {
    bool isExist = false;
    int index = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].username == user.username) {
        isExist = true;
        index = i;
        break;
      }
    }
    if (isExist) {
      return index;
    } else {
      return -1;
    }
  }

  //获取本地用户列表
  Future<List<UserVo>> getList() async {
    RxList<UserVo> list = RxList();
    int size = StorageService.to.get(length) ?? 0;
    for (int i = 0; i < size; i++) {
      list.add(UserVo.fromJson(jsonDecode(StorageService.to.get("$key$i"))));
    }
    return list;
  }

  //保存本地用户列表
  void saveList(List<UserVo> list) {
    int size = list.length;
    for (int i = 0; i < size; i++) {
      StorageService.to.put("$key$i", jsonEncode(list[i]));
    }
    StorageService.to.put(length, size);
  }
}
