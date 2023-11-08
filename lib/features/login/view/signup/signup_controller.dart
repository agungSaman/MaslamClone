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
import '../otp/otp_gmail_page.dart';

class SignUpController extends GetxController {
  AuthDatasource _authDatasource;

  final _isPasswordHidden = true.obs;
  final _isLoading = false.obs;
  final signupGlobalKey = GlobalKey<FormState>();

  final namaTextEditingController = TextEditingController();
  final usernameTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final teleponTextEditingController = TextEditingController();

  final pageViewController = PageController();

  SignUpController(this._authDatasource);

  bool get isPasswordHidden => _isPasswordHidden.value;

  bool get isLoading => _isLoading.value;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  final _currentUser = Rx<GoogleSignInAccount?>(null);
  GoogleSignInAccount? get currentUser => _currentUser.value;

  Future<void> googleSignIn() async {
    Get.toNamed(OtpGmailPage.routeName);
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'masukan alamat email yang benar'
        : null;
  }

  String? isNamaTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'nama tidak boleh kosong';
    }
  }

  String? isTeleponTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'nomor telepon tidak boleh kosong';
    }
  }

  String? isPasswordTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'Password tidak boleh kosong';
    }
  }

  void onPasswordSuffixTapped() {
    _isPasswordHidden.value = !(_isPasswordHidden.value);
  }

  void onTapBackLogin() {
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

  void onTapLoginPage() {
    Get.back();
  }

  void onTapSignUpButton() async {
    if (signupGlobalKey.currentState!.validate()) {
      _isLoading.value = true;

      try {
        //Register to DIO
        var dioInstance = MainBinding.provideDio();
        _authDatasource = AuthDatasourceImpl(dioInstance);

        Get.put<Dio>(dioInstance, tag: defaultNetworkTag, permanent: true);
        Get.put<AuthDatasource>(_authDatasource,
            tag: defaultAuthTag, permanent: true);

        // signup user pw
        var token = await FirebaseMessaging.instance.getToken();
        var deviceid = await getDeviceId();

        await _authDatasource.signUp(
            namaTextEditingController.text,
            usernameTextEditingController.text,
            teleponTextEditingController.text,
            passwordTextEditingController.text,
            token ?? '',
            deviceid??'');

        var user = await _authDatasource.signIn(
            usernameTextEditingController.text,
            passwordTextEditingController.text,
            token ?? '',
            deviceid??'');

        user!.password = passwordTextEditingController.text;
        _authDatasource.saveUserInfo(user);
        initOnNewTokenListener();
        _isLoading.value = false;

        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'Signup Successfully',
            message:
                'Hello ${namaTextEditingController.text}, welcome to Maslam...');

        Get.offAllNamed(MainWrapperPage.routeName,
            // arguments: MainWrapperPageParam(
            //   destination: HomePage.routeName,
            // )
        );
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
