import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/entities/system/log.dart';
import 'package:girt_chat/common/utils/log_file_util.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

enum LogType {
  normal,
  success,
  toast,
  route,
  testRequestTimer,
  testHandleRequest,
  speak;
}

class LogService extends GetxService {
  static LogService get to => Get.find();

  RxList<Log> logList = <Log>[].obs;
  late Logger logger;

  late Directory? directory;

  String logSavePath = "";
  
  late File logFile;

  IOSink? _sink;

  Future<void> init() async {
    // 获取目录地址
    await createDirectory();
    // 初始化Logger
    await initLogger();
    // 日志只保存七天，删除七天前的日志
    await deleteLogsOfBefore7Day();
  }

  @override
  void onClose() {
    _sink!.flush();
    _sink!.close();
    super.onClose();
  }

  Future<void> createDirectory() async {
    if (Platform.isWindows) {
      directory = await getApplicationSupportDirectory();
    } else if (Platform.isAndroid){
      directory = await getExternalStorageDirectory();
    }
    var file = Directory("${directory!.path}/girt-ring/log");
    try {
      bool exist = file.existsSync();
      if (false == exist) {
        await file.create(recursive: true);
      }

      // 打开日志文件
      logSavePath = file.path;

      if (Platform.isAndroid) {
        String currentDate = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);
        logFile = File("$logSavePath/$currentDate.log");
        _sink = logFile.openWrite(
          mode: FileMode.writeOnlyAppend,
          encoding: utf8,
        );
      }

      print("The log file address is: ${file.path}");
    } catch (e) {
      print("createDirectory Error Exception:${e.toString()}");
    }
  }

  // 初始化Logger
  Future<void> initLogger() async {
    if (logSavePath.isNotEmpty) {
      ConsoleOutput consoleOutput = ConsoleOutput();
      List<LogOutput> multiOutput = [consoleOutput];
      if (Platform.isWindows) {
        LogFileUtil logFileUtil = LogFileUtil(logPath: logSavePath);
        multiOutput.add(logFileUtil);
      }
      logger = Logger(
          filter: DevelopmentFilter(),
          printer: HybridPrinter(
              PrettyPrinter(
                  noBoxingByDefault: true,
                  methodCount: 0,
                  errorMethodCount: 8,
                  lineLength: 120,
                  colors: true,
                  printEmojis: true,
                  printTime: false),
              debug: SimplePrinter()),
          output: MultiOutput(multiOutput));
    } else {
      logger = Logger();
      print(
          "The Logger initialization failed and the logSavePath parameter was empty. Perhaps the file creation failed");
    }
  }

  // 每次启动只保留7天内的日志，删除7天前的日志
  Future<void> deleteLogsOfBefore7Day() async {
    if (logSavePath.isNotEmpty) {
      // 获取目录的所有文件
      var dir = Directory(logSavePath);
      Stream<FileSystemEntity> file = dir.list();
      await for (FileSystemEntity x in file) {
        // 获取文件的的名称
        List<String> paths = Platform.isWindows ? x.path.split('\\') : x.path.split('/');
        if (paths.isNotEmpty) {
          String logName = paths.last.replaceAll('.log', '');
          final logDate = DateTime.parse(logName);
          final currentDate = DateTime.now();
          //比较相差的天数
          if (logDate != null) {
            final difference = currentDate.difference(logDate!).inDays;
            print(
                "deleteLogsOfBefore7Day logDate:${logDate}, currentDate:${currentDate}, difference:${difference}");
            if (difference > 7) {
              var file = File(x.path);
              // 删除文件
              file.delete();
            }
          }
        }
      }
    } else {
      print(
          "The logs generated 7 days ago failed to be deleted. The logSavePath parameter is empty. The file creation may fail");
    }
  }

  void log(String text,
      {bool toConsole = true,
      Level level = Level.info,
      LogType logType = LogType.normal}) {
    String msg = text;
    String appName = "girt-ring";
    switch (logType) {
      case LogType.normal:
        msg = "$appName:$text";
        logListPrint(msg, level, toConsole);
        break;
      case LogType.toast:
        msg = "$appName toast:$text";
        logListPrint(msg, level, toConsole);
        break;
      case LogType.route:
        msg = "Get Route To /$text";
        logListPrint(msg, level, toConsole);
        break;
      case LogType.speak:
        msg = "$appName voice broadcast:$text";
        logListPrint(msg, level, toConsole);
        break;
      case LogType.testRequestTimer:
        msg = "$appName:$text";
        logListPrint(msg, level, toConsole, textColor: Colors.orange);
        break;
      case LogType.testHandleRequest:
        msg = "$appName:$text";
        logListPrint(msg, level, toConsole, textColor: Colors.blueAccent);
        break;
      case LogType.success:
        msg = "$appName handle success:$text";
        logListPrint(msg, level, toConsole);
        break;
    }
  }

  void logListPrint(String text, Level level, bool toConsole,
      {Color textColor = const Color.fromRGBO(195, 206, 227, .7)}) async {
    String prefixStr = "";
    Color color = Colors.transparent;
    switch (level) {
      case Level.info:
        prefixStr += "[LogService Info";
        break;
      case Level.error:
        prefixStr += "[LogService Error";
        break;
      case Level.debug:
        prefixStr += "[LogService Debug";
        break;
      case Level.warning:
        prefixStr += "[LogService Warning";
        break;
      case Level.fatal:
        prefixStr += "[LogService Fatal";
        break;
      case Level.off:
        prefixStr += "[LogService Off";
        break;
      case Level.all:
        prefixStr += "[LogService All";
        break;
      case Level.trace:
        prefixStr += "[LogService Trace";
        break;
      default:
        prefixStr += "[LogService Default";
        break;
    }

    String msg = "$prefixStr ${formatDate(DateTime.now(), [
          yyyy,
          '/',
          mm,
          '/',
          dd,
          ' ',
          HH,
          ':',
          nn,
          ':',
          ss
        ])}] $text";

    if (toConsole) {
      logger.log(level, msg);
    }
    logList.add(Log(msg: msg, borderColor: color, textColor: textColor));
    // 将日志内容写入文件
    if (Platform.isAndroid) {
      _sink!.write("$msg\n");
    }
  }

  void clear() {
    logList.clear();
  }
}
