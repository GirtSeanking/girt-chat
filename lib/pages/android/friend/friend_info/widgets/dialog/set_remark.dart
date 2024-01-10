import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';
import 'package:girt_chat/pages/public/buttons.dart';
import 'package:lottie/lottie.dart';

class SetRemarkDialog extends StatefulWidget {
  final Function(String value) onFinished;
  final String hintText;
  final String text;
  const SetRemarkDialog({super.key, required this.onFinished, required this.hintText, required this.text});

  @override
  State<SetRemarkDialog> createState() => _SetRemarkDialogState();
}

class _SetRemarkDialogState extends State<SetRemarkDialog> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController inputEditingController = TextEditingController();
  bool inputFocus = false;

  @override
  void initState() {
    super.initState();
    addInputFocusListener();
    inputEditingController.text = widget.text;
  }

  void addInputFocusListener() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          inputFocus = true;
        });
      }
    });
  }

  void submit() {
    String res = inputEditingController.text;
    Navigator.of(context).pop();
    widget.onFinished(res);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: getWidthByRatio(.7),
          height: getHeightByRatio(.4),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Lottie.asset("assets/set/set_remark_animated.json",
                  height: getHeight(200), width: getWidth(200)),
              Gap(getHeight(10)),
              Container(
                height: getHeight(40),
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color:
                          inputFocus ? AppColors.primaryColor : Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 1,
                    )
                  ],
                ),
                child: Center(
                  child: TextField(
                    controller: inputEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      constraints: const BoxConstraints(maxHeight: 40),
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: widget.hintText
                    ),
                    cursorColor: AppColors.primaryColor,
                  ),
                ),
              ),
              Gap(getHeight(10)),
              AppButton.primary(
                text: "确认",
                onPressed: submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
