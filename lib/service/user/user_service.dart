import 'package:girt_chat/common/entities/user/user_vo.dart';
import 'package:image_picker/image_picker.dart';

abstract class IUserService {
  Future<bool> loginStorage(UserVo user);
  Future<bool> loginIM(UserVo user);
  Future<bool> register(UserVo user);
  Future<void> logout();
  Future<UserVo?> getLocalIsLoginUser();
  Future<UserVo?> getCurrentUser();
  Future<List<UserVo>> searchUserInfo(String key);
  Future<UserVo> getUserInfoByUsername(String username);
  Future<void> updateUserBirthday(String timestamp);
  Future<void> saveNewNickName(UserVo userVo);
  Future<void> saveAvatar(ImageSource imageSource);
  Future<void> saveNewSelfSignature(UserVo userVo);
}