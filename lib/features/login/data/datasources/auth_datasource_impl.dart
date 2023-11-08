import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../../commons/app_exception.dart';
import '../../../../utils/date_formatter.dart';
import '../../../shared/user/data/models/user.dart';
import '../../../shared/user/data/models/user_requirement.dart';
import 'auth_datasource.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio;

  AuthDatasourceImpl(this.dio);

  @override
  Future<User?> signIn(
      String username, String password, String token, String deviceId) async {
    try {
      var response = await dio.get('api/Login', queryParameters: {
        'username': username,
        'pass': password,
        'token': token,
        'device': deviceId
      });
      return User.fromJson(response.data);
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
    } catch (error, stackTrace) {
      debugPrint(stackTrace.toString());
      throw GeneralException(stackTrace.toString());
    }
    return null;
  }

  @override
  Future<String> signUp(String? nama, String? username, String telepon,
      String password, String token, String deviceId) async {
    try {
      var response = await dio.post('api/User/CreateUser', data: {
        'nama': nama,
        'email': username,
        'no_hp': telepon,
        'password': password,
        'device_code': deviceId,
        'device_token': token
      });

      return response.data!;
    } on DioException catch (error) {
      throw error.response!.data.toString();
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<User> signGmail(
      String? nama, String? username, String token, String deviceId) async {
    try {
      var response = await dio.get('api/User/GetUserGmail', queryParameters: {
        'username': username,
        'nama': nama,
        'token': token,
        'device': deviceId
      });

      return User.fromJson(response.data);
    } on DioException catch (error) {
      throw error.response!.data.toString();
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<UserRequirement?> getDataWarga(String? userId) async {
    try {
      var response = await dio.get('api/Warga/ReadWargaByUserId',
          queryParameters: {'userId': userId});
      return UserRequirement.fromJson(response.data);
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
    } catch (error, stackTrace) {
      debugPrint(stackTrace.toString());
      throw GeneralException(stackTrace.toString());
    }
    return null;
  }

  @override
  User? getUserInfo() {
    var box = Hive.box('maslamfrontdb');
    final userJson = box.get('userInfo');
    if (userJson != null) {
      return User.fromJson(Map.from(userJson));
    } else {
      return null;
    }
  }

  @override
  Future<bool> isUserSignedIn() async {
    var userInfo = getUserInfo();
    return userInfo != null;
  }

  @override
  void saveUserInfo(User? user) {
    var box = Hive.box('maslamfrontdb');
    box.put('userInfo', user!.toJson());
  }

  @override
  Future<String?> getToken() async {
    var userData = getUserInfo();
    if (userData!.tokenExpiredDate.dateTime
            .difference((DateTime.now()))
            .inDays <=
        0) {
      var token = await FirebaseMessaging.instance.getToken();
      var newUserInfo = await signIn(
          userData.email, userData.password, token ?? '', await getDeviceId() ?? '');
      saveUserInfo(newUserInfo!);
      return token;
    }
    return userData.token;
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

  @override
  void clearUserInfo() {
    var box = Hive.box('maslamfrontdb');
    box.delete('userInfo');
  }
}
