import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:girt_chat/common/styles/layout.dart';

class OnlineState extends StatelessWidget {
  final bool androidOnline;
  final bool windowsOnline;
  const OnlineState(
      {super.key, this.androidOnline = false, this.windowsOnline = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!androidOnline && !windowsOnline)
          Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFB7272)),
              child: const Text(
                "不在线",
                style: TextStyle(color: Colors.white),
              )),
        if (androidOnline)
          const Badge(
            backgroundColor: Colors.greenAccent,
            child: Icon(
              FluentIcons.phone_12_regular,
              size: 20,
            ),
          ),
        Gap(getWidth(10)),
        if (windowsOnline)
          const Badge(
            backgroundColor: Colors.greenAccent,
            child: Icon(
              FluentIcons.laptop_16_regular,
              size: 20,
            ),
          ),
      ],
    );
  }
}
