import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final Color circleFillColor;
  final Widget icon;

  const CircleIcon(
      {required this.circleFillColor, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: circleFillColor, shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: icon,
        ));
  }
}
