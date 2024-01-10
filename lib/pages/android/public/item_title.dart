import 'package:flutter/material.dart';
import 'package:girt_chat/common/styles/text.dart';

class AndroidItemTitle extends StatelessWidget {
  const AndroidItemTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Row(
        children: [
          Text(
            title,
            style: AppTexts.greyStyles.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
