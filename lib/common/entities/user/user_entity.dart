class UserEntity {
  String? username;
  String? password;
  String? photoUrl;
  String? nickName;
  String? phone;
  String? birthday;
  String? selfSignature;
  String? sex;
  bool? androidOnline;
  bool? windowOnline;
  bool? isLogin;

  UserEntity(
      {this.username,
      this.password,
      this.photoUrl,
      this.nickName,
      this.phone,
      this.birthday,
      this.selfSignature,
      this.sex,
      this.androidOnline,
      this.windowOnline,
      this.isLogin});

  UserEntity.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    photoUrl = json['photoUrl'];
    nickName = json['nickName'];
    phone = json['phone'];
    birthday = json['birthday'];
    selfSignature = json['selfSignature'];
    sex = json['sex'];
    androidOnline = json['androidOnline'];
    windowOnline = json['windowOnline'];
    isLogin = json['isLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['photoUrl'] = photoUrl;
    data['nickName'] = nickName;
    data['phone'] = phone;
    data['birthday'] = birthday;
    data['selfSignature'] = selfSignature;
    data['sex'] = sex;
    data['androidOnline'] = androidOnline;
    data['windowOnline'] = windowOnline;
    data['isLogin'] = isLogin;
    return data;
  }
}
