import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/color.dart';
import 'package:girt_chat/common/styles/layout.dart';

enum SearchInputSize {
  normal,
  small;
}

class AndroidSearchInput extends StatelessWidget {
  final TextEditingController controller;
  final Function() iconButtonOnTap;
  final String? hintText;
  final SearchInputSize size;
  const AndroidSearchInput(
      {super.key,
      required this.controller,
      required this.iconButtonOnTap,
      this.hintText,
      this.size = SearchInputSize.normal});

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = _buildInputDecoration();
    Widget searchBtn = _buildSearchBtn();
    return Container(
      width: size == SearchInputSize.small ? getWidthByRatio(.7) : null,
      margin: size == SearchInputSize.normal
          ? const EdgeInsets.fromLTRB(8, 0, 8, 0)
          : null,
      padding: size == SearchInputSize.normal
          ? const EdgeInsets.fromLTRB(8, 0, 8, 0)
          : const EdgeInsets.fromLTRB(8, 5, 8, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: size == SearchInputSize.normal
            ? BorderRadius.circular(8)
            : BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: inputDecoration,
              cursorColor: AppColors.primaryColor,
            ),
          ),
          searchBtn
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    if (size == SearchInputSize.normal) {
      return InputDecoration(border: InputBorder.none, hintText: hintText);
    } else {
      return InputDecoration(
        contentPadding: EdgeInsets.zero,
        constraints: const BoxConstraints(maxHeight: 40),
        isCollapsed: true,
        border: InputBorder.none,
        hintText: hintText,
      );
    }
  }

  Widget _buildSearchBtn() {
    if (size == SearchInputSize.normal) {
      return InkWell(
        onTap: iconButtonOnTap,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Icon(
            FluentIcons.search_16_regular,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: iconButtonOnTap,
        child: const Icon(
          FluentIcons.search_16_regular,
          color: Color(0xFF666666),
        ),
      );
    }
  }
}
