import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';

class AndroidInput extends StatelessWidget {
  const AndroidInput({super.key, this.hintText});
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidthByRatio(.8),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: TextField(
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(

          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTexts.greyStyles.copyWith(color: Colors.grey.shade400)
        ),
      ),
    );
  }
}
