// ignore_for_file: unused_import

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../../mainwrapper/view/main_wrapper_page.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// primary animation controller
  late AnimationController animationController;

  /// for text opacity
  late Animation<double> opacityController;

  /// for logo positioning
  late Animation<Alignment> positionController;

  var curve = Curves.easeInCirc;

  final AuthDatasource _authDatasource;

  SplashController(this._authDatasource);

  @override
  void onInit() async {
    super.onInit();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    opacityController = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: curve,
    ));

    positionController = Tween<Alignment>(
      begin: Alignment.topCenter,
      end: Alignment.center,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: curve,
      ),
    );

    animationController.addListener(() {
      update();
    });
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 1800));
        _goToHomePage();
        // getPermission();

        // var isUserSignedIn = await _authDatasource.isUserSignedIn();
        // if (isUserSignedIn) {
        //   var message = await FirebaseMessaging.instance.getInitialMessage();
        //   if (message != null) {
        //     /// refactor this if there are more than one notification type
        //     /// (for now, only for approval)
        //     // Get.off(ApprovalPage(),
        //     //     binding: ApprovalBinding(ApprovalType.outstanding),
        //     //     arguments: ApprovalPageParam(
        //     //         type: message.data['tran_status'] == 'W'
        //     //             ? ApprovalType.outstanding
        //     //             : ApprovalType.history,
        //     //         approvalType: message.data['tran_type'],
        //     //         oid: message.data['oid']));
        //   } else {
        //     _goToHomePage();
        //   }
        // } else {
        //   //_goToLoginPage();
        //   _goToHomePage();
        // }
      }
    });
    await Future.delayed(const Duration(milliseconds: 1800));
    await animationController.forward();
  }

  void _goToHomePage() {
    Get.offAllNamed(MainWrapperPage.routeName);
  }

  // void _goToLoginPage() {
  //   Get.offNamed(LoginPage.routeName);
  // }
}
