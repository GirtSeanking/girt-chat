import 'package:flutter/material.dart';
import 'package:girt_chat/common/constants/constants.dart';
import 'package:girt_chat/common/styles/layout.dart';

class AppSexShow extends StatelessWidget {
  final int sex;
  final double size;
  const AppSexShow({super.key, this.sex = Constants.unSex, this.size = 25.0});

  @override
  Widget build(BuildContext context) {
    if (sex == Constants.unSex) {
      return Container();
    } else if (sex == Constants.manSex) {
      return Image.asset("assets/images/boy.png",width: getWidth(size),
        height: getHeight(size),);
    } else {
      return Image.asset("assets/images/girl.png",width: getWidth(size),
        height: getHeight(size),);
    }
  }
}
