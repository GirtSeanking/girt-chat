import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/layout.dart';

class AndroidBackground extends StatelessWidget {
  final Widget child;
  const AndroidBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  // colors: [Color(0xFFE4E5E9), Color(0xFFC9CCD3)],
                colors: [Color(0xFFFAF9F9), Color(0xFFEEEFF0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: SafeArea(child: child),
        ),
      ),
    );
  }
}
