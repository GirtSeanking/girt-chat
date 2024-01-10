import 'dart:io';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();
  late final Box _box;

  init() async {
    final Directory appSupportDir = await getApplicationSupportDirectory();
    await Hive.initFlutter(appSupportDir.path);
    _box = await Hive.openBox("Girt-Ring");
  }

  void put(dynamic key, dynamic value) {
    _box.put(key, value);
  }

  dynamic get(dynamic key) {
    return _box.get(key);
  }

  void delete(dynamic key) {
    _box.delete(key);
  }

  void deleteAll() {
    int size = length();
    for (int i = 0; i < size; i ++) {
      _box.deleteAt(i);
    }
  }

  int length() {
    return _box.length;
  }

  Map map() {
    return _box.toMap();
  }

  String showAll() {
    return _box.values.toList().toString();
  }
}