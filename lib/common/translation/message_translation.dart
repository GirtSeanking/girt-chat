import 'package:get/get.dart';

class Messages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': {
      'login': "登录",
      'registerNewUser': "注册新用户",
      'loginSubTitle': "真实的社交，真实的圈子",
      'sexChooseLabel': "请选择性别",
      'usernameInputLabel': "请输入账户(1-12字)",
      'passwordInputLabel': "请输入密码",
      'phoneInputLabel': "请输入手机号",
      'registerNextBtnText': "下一步",
      'registerFinishBtnText': "注册",
      'registerSuccess': "注册成功",
      'usernameExisted': "用户名已存在",
      'loginSuccess': "登录成功",
      'loginFormError': "用户名或密码错误",
      'usernameNullError': "用户名不能为空",
      'passwordNullError': "密码不能为空",
    },
    'en_US': {
      'login': "Login",
      'registerNewUser': "Register",
      'loginSubTitle': "True friends and joy",
      'sexChooseLabel': "Please select sex",
      'usernameInputLabel': "Please input username (1-12 words)",
      'passwordInputLabel': "Please input password",
      'phoneInputLabel': "Please input phone number",
      'registerNextBtnText': "Next",
      'registerFinishBtnText': "Register",
      'registerSuccess': "Register Success",
      'usernameExisted': "The username existed",
      'loginSuccess': "Login Success",
      'loginFormError': "The user name or password is incorrect",
      'usernameNullError': "The user name cannot be empty",
      'passwordNullError': "The password cannot be empty",
    }
  };
}