import 'package:date_format/date_format.dart';
import 'package:girt_chat/common/constants/constants.dart';

class DateUtil {
  static String convertMsgTime(int timestamp) {
    var paramDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var now = DateTime.now();
    var justNow = now.subtract(const Duration(minutes: 2));
    if (!paramDate.difference(justNow).isNegative) {
      return "现在";
    }

    if (paramDate.year == now.year &&
        paramDate.month == now.month &&
        paramDate.day == now.day) {
      return formatDate(paramDate, [HH, ":", nn]);
    }

    DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (paramDate.year == yesterday.year &&
        paramDate.month == yesterday.month &&
        paramDate.day == yesterday.day) {
      return "昨天 ${formatDate(paramDate, [HH, ":", nn])}";
    }

    int nowWeekDay = now.weekday;
    var weekDate = now.subtract(Duration(days: nowWeekDay));
    if (paramDate.isAfter(weekDate)) {
      return Constants.weekDaysString[paramDate.weekday] ??
          formatDate(paramDate, [yy, "-", mm, "-", dd]);
    }

    return formatDate(paramDate, [yy, "-", mm, "-", dd]);
  }

  static int calAge(int timestamp) {
    var paramDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var now = DateTime.now();
    return now.year - paramDate.year;
  }

  static List<int> getYears() {
    var now = DateTime.now();
    int currentYear = now.year;
    List<int> res = [];
    for(int i = 1970; i <= currentYear + 50; i ++) {
      res.add(i);
    }
    return res;
  }

  static List<int> getMonths() {
    List<int> res = [];
    for(int i = 1; i <= 12; i ++) {
      res.add(i);
    }
    return res;
  }

  static List<int> getDays(int year, int month) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<int> res = [];
    for(int i = 1; i <= daysInMonth; i ++) {
      res.add(i);
    }
    return res;
  }
}
