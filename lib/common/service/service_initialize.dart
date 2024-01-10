import 'package:get/get.dart';
import 'package:girt_chat/common/service/encryption_service.dart';
import 'package:girt_chat/common/service/im_service.dart';
import 'package:girt_chat/common/service/log_service.dart';
import 'package:girt_chat/common/service/storage_service.dart';


Future<void> serviceInit() async {
  Get.put(LogService());
  Get.put(StorageService());
  Get.put(EncryptionService());
  Get.put(IMService());


  // 初始化
  await LogService.to.init();
  await StorageService.to.init();
  await IMService.to.init();
}
