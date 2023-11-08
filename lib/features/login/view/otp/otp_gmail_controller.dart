import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../commons/app_exception.dart';
import '../../../../consts/binding_const.dart';
import '../../../../main_binding.dart';
import '../../../home/view/home_page.dart';
import '../../../mainwrapper/view/main_wrapper_controller.dart';
import '../../../mainwrapper/view/main_wrapper_page.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../data/datasources/auth_datasource_impl.dart';

class OtpGmailController extends GetxController {
  AuthDatasource _authDatasource;

  // final _isPasswordHidden = true.obs;
  final _isLoading = false.obs;
  final otpGlobalKey = GlobalKey<FormState>();

  // final passwordTextEditingController = TextEditingController();
  final teleponTextEditingController = TextEditingController();

  final pageViewController = PageController();

  OtpGmailController(this._authDatasource);

  // bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isLoading => _isLoading.value;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  final _currentUser = Rx<GoogleSignInAccount?>(null);
  GoogleSignInAccount? get currentUser => _currentUser.value;

  // Future<void> googleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();

  //     if (currentUser != null) {
  //       insertMailData();
  //     }
  //   } catch (error) {
  //     Get.rawSnackbar(
  //         snackPosition: SnackPosition.TOP, message: error.toString());
  //   }
  // }

  // void insertMailData() async {
  //   _isLoading.value = true;

  //   try {
  //     //Register to DIO
  //     var dioInstance = MainBinding.provideDio();
  //     _authDatasource = AuthDatasourceImpl(dioInstance);

  //     Get.put<Dio>(dioInstance, tag: defaultNetworkTag, permanent: true);
  //     Get.put<AuthDatasource>(_authDatasource,
  //         tag: defaultAuthTag, permanent: true);

  //     // Login user pw
  //     var deviceid = await getDeviceId();
  //     var token = await FirebaseMessaging.instance.getToken();
  //     var user = await _authDatasource.signGmail(
  //         currentUser!.displayName, currentUser!.email, token ?? '', deviceid);

  //     //user!.password = passwordTextEditingController.text;
  //     _authDatasource.saveUserInfo(user);
  //     initOnNewTokenListener();
  //     _isLoading.value = false;

  //     Get.rawSnackbar(
  //         snackPosition: SnackPosition.TOP,
  //         title: 'Otp Successfully',
  //         message: 'Hello ${currentUser!.displayName}, welcome to Maslam...');

  //     Get.offAllNamed(MainWrapperPage.routeName,
  //         arguments: MainWrapperPageParam(
  //           destination: HomePage.routeName,
  //         ));
  //   } catch (error) {
  //     _isLoading.value = false;
  //     if (error is UserNotFoundException) {
  //       Get.rawSnackbar(
  //           snackPosition: SnackPosition.TOP,
  //           message: 'Invalid username or password');
  //     } else {
  //       Get.rawSnackbar(
  //           snackPosition: SnackPosition.TOP,
  //           message: 'A problem occurred in the app, please try again');
  //     }
  //   }
  // }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  // String? isPasswordTextFormValid(String? value) {
  //   if (isFormFieldNotNullAndNotEmpty(value)) {
  //     return null;
  //   } else {
  //     return 'Password cannot be empty';
  //   }
  // }

  // void onPasswordSuffixTapped() {
  //   _isPasswordHidden.value = !(_isPasswordHidden.value);
  // }

  void onTapBackSignUp() {
    pageViewController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      var androidInfo = await Get.find<DeviceInfoPlugin>().androidInfo;
      return androidInfo.id;
    } else {
      var iosInfo = await Get.find<DeviceInfoPlugin>().iosInfo;
      return iosInfo.identifierForVendor;
    }
  }

  void onTapSignUpPage() {
    Get.back();
  }

  void onTapOtpButton() async {
    if (otpGlobalKey.currentState!.validate()) {
      _isLoading.value = true;

      try {
        await _googleSignIn.signIn();

        if (currentUser != null) {
          //Register to DIO
          var dioInstance = MainBinding.provideDio();
          _authDatasource = AuthDatasourceImpl(dioInstance);

          Get.put<Dio>(dioInstance, tag: defaultNetworkTag, permanent: true);
          Get.put<AuthDatasource>(_authDatasource,
              tag: defaultAuthTag, permanent: true);

          var token = await FirebaseMessaging.instance.getToken();
          var deviceid = await getDeviceId();

          await _authDatasource.signUp(
              currentUser!.displayName,
              currentUser!.email,
              teleponTextEditingController.text,
              currentUser!.id,
              token ?? '',
              deviceid??'');

          var user = await _authDatasource.signGmail(currentUser!.displayName,
              currentUser!.email, token ?? '', deviceid??'');

          //user!.password = passwordTextEditingController.text;
          _authDatasource.saveUserInfo(user);
          initOnNewTokenListener();
          _isLoading.value = false;

          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              title: 'Sign Up Successfully',
              message:
                  'Hello ${currentUser!.displayName}, welcome to Maslam...');

          Get.offAllNamed(MainWrapperPage.routeName,
              arguments: MainWrapperPageParam(
                destination: HomePage.routeName,
              ));
        }
      } catch (error) {
        _isLoading.value = false;
        if (error.toString().contains('duplicate')) {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              message: 'Tidak dapat Sign Up, User telah terdaftar');
        } else if (error is UserNotFoundException) {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              message: 'Invalid username or password');
        } else {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              message: 'A problem occurred in the app, please try again');
        }
      }
    }
  }

  void initOnNewTokenListener() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      var authDatasource = Get.find<AuthDatasource>();
      var userInfo = await authDatasource.signIn(
          authDatasource.getUserInfo()!.email,
          authDatasource.getUserInfo()!.password,
          event,
          await getDeviceId()??'');
      _authDatasource.saveUserInfo(userInfo!);
    });
  }

  @override
  void onInit() {
    _googleSignIn.onCurrentUserChanged.listen((event) {
      _currentUser.value = event;
    });
    _googleSignIn.signInSilently();
    super.onInit();
  }
}
