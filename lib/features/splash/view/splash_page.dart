// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  static const routeName = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
            stops: [0.1, 0.85],
            colors: [
              Color.fromRGBO(7, 56, 130, 1.0),
              Color.fromRGBO(7, 56, 130, 1.0)
            ],
          ),
        ),
        child: GetBuilder<SplashController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: Stack(
              children: [
                AnimatedAlign(
                    duration: const Duration(milliseconds: 800),
                    alignment: controller.positionController.value,
                    child: Image.asset(
                        'assets/logos/maslam_transparent_logo.png',
                        width: MediaQuery.of(context).size.width / 360 * 100,
                        height: MediaQuery.of(context).size.width / 360 * 75)),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
