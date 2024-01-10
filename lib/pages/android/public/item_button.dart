import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';

class AndroidItemButton extends StatelessWidget {
  const AndroidItemButton(
      {super.key, this.iconData, required this.onTap, required this.label});
  final IconData? iconData;
  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: getHeight(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: ObjectUtil.isNotBlank(iconData),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: getHeight(20),
                        child: Center(
                          child: Icon(iconData),
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(20),
                  child: Center(
                    child: Text(
                      label,
                      style: AppTexts.defaultStyles,
                    ),
                  ),
                )
              ],
            ),
            Icon(
              FluentIcons.ios_arrow_rtl_24_regular,
              color: Colors.grey.shade400,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
