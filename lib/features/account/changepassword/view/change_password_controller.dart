import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/user_datasource.dart';

class ChangePasswordController extends GetxController {
  final AuthDatasource authDatasource;
  final UserDatasource userDatasource;

  final _isCurrentPasswordHidden = true.obs;
  final _isNewPasswordHidden = true.obs;
  final _isConfirmNewPasswordHidden = true.obs;
  final _isLoading = false.obs;

  bool get isCurrentPasswordHidden => _isCurrentPasswordHidden.value;

  bool get isNewPasswordHidden => _isNewPasswordHidden.value;

  bool get isConfirmNewPasswordHidden => _isConfirmNewPasswordHidden.value;

  bool get isLoading => _isLoading.value;

  final changePasswordGlobalKey = GlobalKey<FormState>();

  final currentPasswordTextEditingController = TextEditingController();
  final newPasswordTextEditingController = TextEditingController();
  final confirmNewPasswordTextEditingController = TextEditingController();

  ChangePasswordController(this.authDatasource, this.userDatasource);

  void onTapBackButton() {
    Get.back();
  }

  void onTapCurrentPasswordSuffix() {
    _isCurrentPasswordHidden.value = !(_isCurrentPasswordHidden.value);
  }

  void onTapNewPasswordSuffix() {
    _isNewPasswordHidden.value = !(_isNewPasswordHidden.value);
  }

  void onTapConfirmNewPasswordSuffix() {
    _isConfirmNewPasswordHidden.value = !(_isConfirmNewPasswordHidden.value);
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? isCurrentPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      var currentPass = authDatasource.getUserInfo()!.password;
      if (currentPass != value) {
        return 'Incorrect current password';
      }
      return null;
    } else {
      return 'Current password cannot be empty';
    }
  }

  String? isNewPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (value != confirmNewPasswordTextEditingController.text) {
        return 'New Password and Repeat Password must match';
      }
      return null;
    } else {
      return 'New Password cannot be empty';
    }
  }

  String? isConfirmNewPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      if (value != newPasswordTextEditingController.text) {
        return 'New Password and Repeat Password must match';
      }
      return null;
    } else {
      return 'Repeat Password cannot be empty';
    }
  }

  void onTapChangePassword() async {
    if (changePasswordGlobalKey.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var userInfo = authDatasource.getUserInfo();
        await userDatasource.changePassword(
            currentPasswordTextEditingController.text,
            newPasswordTextEditingController.text,
            userInfo!.userId,
            userInfo.email);
        _isLoading.value = false;
        userInfo.password = newPasswordTextEditingController.text;
        authDatasource.saveUserInfo(userInfo);
        Get.back(result: true);
      } catch (error) {
        _isLoading.value = false;
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'An error occurred',
            message: 'Please try again');
      }
    }
  }
}
