import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/common/routes/pages.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/translation/message_translation.dart';
import 'package:logger/logger.dart';
import 'package:leancloud_storage/leancloud.dart';
import 'package:oktoast/oktoast.dart';

import 'package:window_manager/window_manager.dart';



void main() async {
  LeanCloud.initialize(
    "VmpuUULpEkWTSNXwJ4VyGWID-gzGzoHsz",
    "vLg7fU3QcID4QSthxPtgYZkx",
    server: "https://vmpuuulp.lc-cn-n1-shared.com",
  );
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: windowInitialSize,
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    windowManager.setMinimumSize(windowInitialSize);
  } else if (Platform.isAndroid) {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }
  runApp(const MyApp());
}

// 全局异常捕捉
class AppCatchError {
  run(Widget app) async {
    // Flutter 框架异常
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (kReleaseMode) {
        // 线上环境
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      } else {
        // 开发状态 print
        FlutterError.dumpErrorToConsole(details);
      }
    };

    runZonedGuarded(() async {
      // configLoading();
      runApp(app);
    }, (error, stack) {
      LogService.to.log("AppCatchError message:$error\nstack:$stack",
          level: Level.error);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splashScreen,
        getPages: RoutePages.routes,
        translations: Messages(),
        locale: const Locale('zh', 'CN'),
        fallbackLocale: const Locale('zh', 'CN'),
      ),
    );
  }
}
