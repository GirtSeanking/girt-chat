import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:window_manager/window_manager.dart';

class LoginOrRegisterPageBackground extends StatefulWidget {
  final List<Widget> children;
  const LoginOrRegisterPageBackground({super.key, required this.children});

  @override
  State<LoginOrRegisterPageBackground> createState() => _LoginOrRegisterPageBackgroundState();
}

class _LoginOrRegisterPageBackgroundState extends State<LoginOrRegisterPageBackground> {
  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          if (GetPlatform.isWindows) windowManager.startDragging();
        },
        child: Stack(
          children: [
            Positioned(
              bottom: -50,
              left: -80,
              child: Container(
                width: getWidth(200),
                height: getHeight(200),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(200)),
                    color: Colors.black,
                    gradient: const LinearGradient(colors: [
                      Color(0xFFFA7199),
                      Color(0xFFFEE141),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]),
              ),
            ),
            Positioned(
              top: -20,
              left: -80,
              child: Container(
                width: getWidth(170),
                height: getHeight(170),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(170)),
                    color: Colors.black,
                    gradient: const LinearGradient(colors: [
                      Color(0xFFF7F587),
                      Color(0xFF98FBC4),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]),
              ),
            ),
            Positioned(
              top: 60,
              right: 30,
              child: Container(
                width: getWidth(100),
                height: getHeight(100),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(100)),
                    color: Colors.black,
                    gradient: const LinearGradient(colors: [
                      Color(0xFF2AF49A),
                      Color(0xFF009EFC),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 130,
              child: Container(
                width: getWidth(80),
                height: getHeight(80),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(80)),
                    color: Colors.black,
                    gradient: const LinearGradient(colors: [
                      Color(0xFFFA7199),
                      Color(0xFFFEE141),
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 80,
              child: Container(
                width: getWidth(60),
                height: getHeight(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getHeight(60)),
                    color: Colors.black,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFA7199),
                        Color(0xFFFEE141),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ]),
              ),
            ),
            Platform.isWindows ? Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      windowManager.minimize();
                    },
                    child: const Icon(Icons.minimize_sharp),
                  ),
                  InkWell(
                    onTap: () {
                      windowManager.close();
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
            ),
              ),) : Container(),
            Center(
              child: Container(
                padding: EdgeInsets.all(getHeight(20)),
                height: getHeight(500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
