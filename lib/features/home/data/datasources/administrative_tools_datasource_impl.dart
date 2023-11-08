import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../commons/app_exception.dart';
import '../../../login/data/datasources/auth_datasource.dart';

import '../models/menu_feature_flag.dart';
import 'administrative_tools_datasource.dart';

class AdministrativeToolsDatasourceImpl extends AdministrativeToolsDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  AdministrativeToolsDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<MenuFeatureFlag>> getMenuFeatureFlag(String userId) async {
    try {
      var response = await dio.get(
          'api/GetAdministrativeToolsData/GetMenuAccessMobile',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'userid': userId, 'module_name': 'home'});
      return (response.data as List)
          .map((item) => MenuFeatureFlag.fromJson(item))
          .toList();
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<MenuFeatureFlag>> getDashboardMenuFeatureFlag(
      String userId) async {
    try {
      var response = await dio.get(
          'api/GetAdministrativeToolsData/GetMenuAccessMobile',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'userid': userId, 'module_name': 'dashboard'});
      return (response.data as List)
          .map((item) => MenuFeatureFlag.fromJson(item))
          .toList();
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
