import 'package:get/get.dart';
import 'package:girt_chat/common/routes/name.dart';
import 'package:girt_chat/pages/android/chat/binding.dart';
import 'package:girt_chat/pages/android/chat/view.dart';
import 'package:girt_chat/pages/android/friend/friend_apply_list/binding.dart';
import 'package:girt_chat/pages/android/friend/friend_apply_list/view.dart';
import 'package:girt_chat/pages/android/friend/friend_info/binding.dart';
import 'package:girt_chat/pages/android/friend/friend_info/view.dart';
import 'package:girt_chat/pages/android/friend/friend_list/binding.dart';
import 'package:girt_chat/pages/android/friend/friend_list/view.dart';
import 'package:girt_chat/pages/android/friend/friend_search/binding.dart';
import 'package:girt_chat/pages/android/friend/friend_search/view.dart';
import 'package:girt_chat/pages/android/friend/new_friend_search/binding.dart';
import 'package:girt_chat/pages/android/friend/new_friend_search/pages/friend_apply.dart';
import 'package:girt_chat/pages/android/friend/new_friend_search/view.dart';
import 'package:girt_chat/pages/android/home/binding.dart';
import 'package:girt_chat/pages/android/home/view.dart';
import 'package:girt_chat/pages/android/setting/account_and_security/binding.dart';
import 'package:girt_chat/pages/android/setting/account_and_security/view.dart';
import 'package:girt_chat/pages/android/setting/setting/binding.dart';
import 'package:girt_chat/pages/android/setting/setting/view.dart';
import 'package:girt_chat/pages/android/setting/user/set_birth_day/binding.dart';
import 'package:girt_chat/pages/android/setting/user/set_birth_day/view.dart';
import 'package:girt_chat/pages/android/setting/user/set_new_password/binding.dart';
import 'package:girt_chat/pages/android/setting/user/set_new_password/view.dart';
import 'package:girt_chat/pages/android/setting/user/set_nick_name/binding.dart';
import 'package:girt_chat/pages/android/setting/user/set_nick_name/view.dart';
import 'package:girt_chat/pages/android/setting/user/set_self_signature/binding.dart';
import 'package:girt_chat/pages/android/setting/user/set_self_signature/view.dart';
import 'package:girt_chat/pages/login_register/login/binding.dart';
import 'package:girt_chat/pages/login_register/login/view.dart';
import 'package:girt_chat/pages/login_register/register/binding.dart';
import 'package:girt_chat/pages/login_register/register/view.dart';
import 'package:girt_chat/pages/splash_screen/binding.dart';
import 'package:girt_chat/pages/splash_screen/view.dart';
import 'package:girt_chat/pages/windows/main/binding.dart';
import 'package:girt_chat/pages/windows/main/view.dart';

class RoutePages {
  static final List<GetPage> routes = [
    GetPage(
        name: RouteName.splashScreen,
        page: () => const SplashScreenPage(),
        binding: SplashScreenBinding(),
        transition: Transition.fadeIn),
    GetPage(
      name: RouteName.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.androidHome,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.androidNewFriendSearch,
      page: () => const NewFriendSearchPage(),
      binding: NewFriendSearchBinding(),
    ),
    GetPage(
      name: RouteName.androidFriendApply,
      page: () => const FriendApplyPage(),
    ),
    GetPage(
      name: RouteName.androidFriendSearch,
      page: () => const FriendSearchPage(),
      binding: FriendSearchBinding(),
    ),
    GetPage(
      name: RouteName.androidFriendApplyList,
      page: () => const FriendApplyListPage(),
      binding: FriendApplyListBinding(),
    ),
    GetPage(
      name: RouteName.androidFriendList,
      page: () => const FriendListPage(),
      binding: FriendListBinding(),
    ),
    GetPage(
      name: RouteName.androidFriendInfo,
      page: () => const FriendInfoPage(),
      binding: FriendInfoBinding(),
    ),
    GetPage(
      name: RouteName.androidChatPage,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: RouteName.androidSettingPage,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: RouteName.androidAccountAndSecurity,
      page: () => const AccountAndSecurityPage(),
      binding: AccountAndSecurityBinding(),
    ),
    GetPage(
      name: RouteName.androidSetBirthday,
      page: () => const SetBirthDayPage(),
      binding: SetBirthDayBinding(),
    ),
    GetPage(
      name: RouteName.androidSetNickName,
      page: () => const SetNickNamePage(),
      binding: SetNickNameBinding(),
    ),
    GetPage(
      name: RouteName.androidSetSelfSignature,
      page: () => const SetSelfSignaturePage(),
      binding: SetSelfSignatureBinding(),
    ),
    GetPage(
      name: RouteName.androidSetNewPassword,
      page: () => const SetNewPasswordPage(),
      binding: SetNewPasswordBinding(),
    ),
    GetPage(
      name: RouteName.windowsMain,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
  ];
}
