import 'package:flutter/material.dart';

class AppBadgeBox extends StatelessWidget {
  final Widget child;
  final int count;
  const AppBadgeBox({super.key, required this.child, required this.count});

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(count > 99 ? "99+" : count.toString()),
      isLabelVisible: count > 0,
      textStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      child: child,
    );
  }
}
