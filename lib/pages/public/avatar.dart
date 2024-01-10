import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:girt_chat/common/styles/text.dart';
import 'package:girt_chat/common/utils/object_util.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final ImageProvider<Object>? image;
  final double size;
  const AppAvatar(
      {super.key, required this.name, required this.image, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
            colors: [Color(0xFFB26FDD), Color(0xFF924899)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 6)
        ],
      ),
      child: image == null
          ? Center(
              child: Text(
                ObjectUtil.stringIsNotBlank(name)
                    ? name.substring(0, 1).toUpperCase()
                    : "空",
                style: AppTexts.defaultStyles.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ClipOval(
              child: Image(
                image: image!,
              ),
            ),
    );
    // return AdvancedAvatar(
    //   name: name,
    //   image: image,
    //   size: size,
    //   animated: true,
    //   decoration: const BoxDecoration(
    //     shape: BoxShape.circle,
    //     gradient: LinearGradient(
    //       colors: [Color(0xFFB26FDD), Color(0xFF924899)],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black12,
    //         spreadRadius: 2,
    //         blurRadius: 6,
    //       )
    //     ],
    //   ),
    // );
  }
}
