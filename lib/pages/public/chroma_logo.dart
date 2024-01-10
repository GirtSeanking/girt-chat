import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/layout.dart';

class ChromaLogo extends StatelessWidget {
  const ChromaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          // colors: [Color(0xFFB36FDF), Color(0xFF924899)],
          colors: [Color(0xFFECA3A3), Color(0xFF5AC5E1), Color(0xFFB3A0DA), Color(0xFF7CC3D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Offset.zero & bounds.size);
      },
      blendMode: BlendMode.srcATop,
      child: Text(
        "girt-ring",
        style: TextStyle(
            fontSize: getHeight(50),
            fontFamily: "Borel",
            color: Colors.white),
      ),
    );
  }
}
