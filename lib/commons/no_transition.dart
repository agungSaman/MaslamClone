import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoTransition extends CustomTransition {
  @override
  Widget buildTransition(
          BuildContext context,
          Curve? curve,
          Alignment? alignment,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      child;
}
