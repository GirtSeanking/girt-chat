import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

class EncryptionService extends GetxService {
  static EncryptionService get to => Get.find();

  late Encrypter _encrypter;
  late IV _iv;

  @override
  void onInit() {
    _encrypter = Encrypter(AES(Key.fromLength(32)));
    _iv = IV.fromLength(16);
    super.onInit();
  }

  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  String encrypt(String text) {
    return _encrypter.encrypt(text, iv: _iv).base64;
  }
}
