import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';

class AndroidPageHead extends StatelessWidget {
  final String? label;
  final Function()? onBack;
  final List<DropdownMenuItem>? dropdownItems;
  final Widget? icon;
  final double? dropdownWidth;
  final Function(dynamic value)? onChanged;
  final String? buttonText;
  final Function()? buttonOnClick;
  const AndroidPageHead(
      {super.key,
      this.label,
      this.onBack,
      this.dropdownItems,
      this.icon,
      this.dropdownWidth,
      this.onChanged,
      this.buttonText,
      this.buttonOnClick});

  void defaultBack() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    late MainAxisAlignment mainAxisAlignment;
    bool labelShow = ObjectUtil.stringIsNotBlank(label);
    bool dropdownShow = ObjectUtil.listIsNotBlank(dropdownItems);
    bool buttonShow = !dropdownShow && ObjectUtil.stringIsNotBlank(buttonText);
    late Widget labelWidget;
    if (labelShow && (dropdownShow || buttonShow)) {
      mainAxisAlignment = MainAxisAlignment.spaceAround;
      labelWidget = Expanded(
          child: Center(
              child: Text(
        label!,
        style: AppTexts.defaultStyles,
      )));
    } else {
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
      if (labelShow) {
        labelWidget = Text(
          label!,
          style: AppTexts.defaultStyles,
        );
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          GestureDetector(
            onTap: onBack ?? defaultBack,
            child: const Icon(FluentIcons.ios_arrow_24_filled),
          ),
          if (labelShow) labelWidget,
          if (dropdownShow)
            DropdownButton2(
              items: dropdownItems,
              customButton: icon ?? const Icon(FluentIcons.list_24_regular),
              onChanged: onChanged,
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.zero,
                width: dropdownWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          if (buttonShow)
            ElevatedButton(
              onPressed: buttonOnClick,
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(3)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryColor),
                  minimumSize: MaterialStateProperty.all(const Size(50, 30))),
              child: Text(
                buttonText!,
                style: AppTexts.mediaWhiteStyles,
              ),
            ),
        ],
      ),
    );
  }
}
