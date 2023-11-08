import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'consts/binding_const.dart';
import 'features/login/data/datasources/auth_datasource.dart';
import 'features/login/data/datasources/auth_datasource_impl.dart';

class MainBinding extends Bindings {
  static const baseUrl = 'http://172.104.163.223:86/';
  //static const baseUrl = 'http://localhost:5001/';

  @override
  Future<bool> dependencies() async {
    Get.put(provideDio(), tag: defaultNetworkTag, permanent: true);
    var defaultAuthDatasource = AuthDatasourceImpl(provideDio());
    Get.put<AuthDatasource>(defaultAuthDatasource,
        tag: defaultAuthTag, permanent: true);
    Get.put(DeviceInfoPlugin(), permanent: true);
    return true;
  }

  static Dio provideDio() {
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    );
    var dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
      final baseUrl = option.baseUrl;
      final path = option.path;
      debugPrint('Request [${baseUrl + path}] : '
          '${option.queryParameters.toString()}');
      debugPrint('header [${option.headers.toString()}] ');
      return handler.next(option);
    }, onResponse: (response, handler) {
      debugPrint('Response body: ${response.toString()}');
      return handler.next(response);
    }, onError: (error, handler) {
      debugPrint(error.response.toString());
      return handler.next(error);
    }));
    return dio;
  }
}
