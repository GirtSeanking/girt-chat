import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:logger/logger.dart';

class LogFileUtil extends LogOutput {
  final bool overrideExisting;
  final Encoding encoding;
  final String logPath;
  IOSink? _sink;

  File? file;
  String? _currentDate;

  LogFileUtil({required this.logPath, this.overrideExisting = false, this.encoding = utf8});

  Future<void> getDirectoryForLogRecord() async {
    String currentDate = getCurrentDay();
    if (currentDate != _currentDate) {
      file = File('$logPath/$currentDate.log');

      _sink = file!.openWrite(
        mode: overrideExisting ? FileMode.writeOnly : FileMode.writeOnlyAppend,
        encoding: encoding,
      );

      _currentDate = currentDate;
    }
  }

  String getCurrentDay() {
    String currentDate = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);
    return currentDate;
  }

  @override
  Future<void> init() async {
    directoryLogRecord(onCallback: () {});
  }

  void directoryLogRecord({required Function onCallback}) {
    getDirectoryForLogRecord().whenComplete(() {
      onCallback();
    });
  }

  @override
  void output(OutputEvent event) {
    directoryLogRecord(onCallback: () {
      if (_sink != null) {
        if (Level.info == event.level ||
            Level.warning == event.level ||
            Level.error == event.level) {
          _sink?.write("${event.origin.message}\n");
        }
      }
    });
  }

  @override
  Future<void> destroy() async {
    await _sink?.flush();
    await _sink?.close();
  }
  
}