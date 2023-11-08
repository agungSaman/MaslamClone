import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../login/data/datasources/auth_datasource.dart';
import '../../shared/user/data/models/user.dart';

class PasswordAuthController extends GetxController {
  final AuthDatasource _authDatasource;

  PasswordAuthController(this._authDatasource);

  final passwordTextEditingController = TextEditingController();

  late User userData;

  final _isPasswordHidden = true.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;

  @override
  void onInit() {
    super.onInit();

    userData = _authDatasource.getUserInfo()!;
  }

  void onPasswordSuffixTapped() {
    _isPasswordHidden.value = !(_isPasswordHidden.value);
  }

  void onTapBackButton() {
    Get.back();
  }

  void onTapConfirmButton() {
    if (passwordTextEditingController.text == userData.password) {
      Get.back(result: true);
    } else if (passwordTextEditingController.text.isEmpty) {
      Get.rawSnackbar(
          title: 'Password cannot be empty',
          message: 'Please enter your password to continue');
    } else {
      Get.rawSnackbar(
          title: 'Auth process failed',
          message: 'Password entered is not match');
    }
  }
}
