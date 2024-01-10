import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';

class ObjectUtil {
  // 判断string字符串是否不为空
  static bool stringIsNotBlank(String? val) {
    return val != null && val.isNotEmpty;
  }

  // 判断list列表不为空
  static bool listIsNotBlank(List<Object>? list) {
    return list != null && list.isNotEmpty;
  }

  static bool isNotBlank(Object? object) {
    bool isNotNull = object != null;
    if (isNotNull) {
      return !object.isBlank!;
    } else {
      return false;
    }
  }

  // 获取字符串中第一个大写的值
  static String getFirstUpperCase(String? str) {
    if (stringIsNotBlank(str)) {
      String res = "";
      for (int i = 0; i < str!.length; i++) {
        if (str.codeUnitAt(i) >= 97 && str.codeUnitAt(i) <= 122) {
          res = str.substring(i, i + 1).toUpperCase();
        } else if (str.codeUnitAt(i) >= 65 && str.codeUnitAt(i) <= 90) {
          res = str.substring(i, i + 1);
        } else {
          String firstLetters = PinyinHelper.getPinyin(str.substring(i, i + 1));
          res = firstLetters.substring(0, 1).toUpperCase();
        }
        if (res.codeUnitAt(0) >= 65 && res.codeUnitAt(0) <= 90) {
          return res;
        }
      }
      return "";
    } else {
      return "";
    }
  }
}
