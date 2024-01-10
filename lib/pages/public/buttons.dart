import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double width;
  final double height;

  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.bgColor = Colors.white,
      this.textColor = Colors.black,
      this.width = 130, this.height = 45});

  const AppButton.primary(
      {super.key,
      required this.text,
      required this.onPressed,
      this.bgColor = AppColors.primaryColor,
      this.textColor = Colors.white,
      this.width = 130, this.height = 45});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(width),
      height: getHeight(height),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
        ),
        child: Text(
          text,
          style: AppTexts.defaultStyles.copyWith(color: textColor),
        ),
      ),
    );
  }
}
