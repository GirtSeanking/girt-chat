import 'package:flutter_test/flutter_test.dart';
import 'package:girt_chat/common/utils/date_util.dart';
import 'package:girt_chat/common/utils/object_util.dart';
import 'package:lpinyin/lpinyin.dart';

void main() {
  test("测试日期", () {
    var param = DateTime(2023, 10, 29, 10, 54);
    var param2 = DateTime(2001, 10, 29, 10, 54);
    print(
        DateUtil.convertMsgTime((param.millisecondsSinceEpoch / 1000).ceil()));
    print(DateUtil.calAge((param2.millisecondsSinceEpoch / 1000).ceil()));
  });

  test("测试获取汉字拼音", () {
    String testText = "。";
    print(ObjectUtil.getFirstUpperCase(testText));
  });

  test("测试双层for循环耗时", () {
    var start = DateTime.now();
    for (int i = 0; i < 26; i ++) {
      for (int j = 0; j < 5000; j++) {
        String item = "";
        item = "$i + $j = ${i + j}";
      }
    }
    var end = DateTime.now();
    print("耗时为：${end.millisecond - start.millisecond} ms");
  });
}
