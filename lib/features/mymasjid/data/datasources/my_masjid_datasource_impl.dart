// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../commons/app_exception.dart';
import '../../../../utils/date_formatter.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../models/my_masjid_list.dart';
import 'my_masjid_datasource.dart';

class MyMasjidDatasourceImpl extends MyMasjidDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  MyMasjidDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<MyMasjidList>> readMyMasjidList(String userId, double latitude,
      double longitude, String cari, int page, int pageSize) async {
    try {
      var response = await dio.get('api/Masjid/ReadMyMasjid',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'userId': userId,
            'myLatitude': latitude,
            'myLongitude': longitude,
            'cari': cari,
            'page': page,
            'pageSize': pageSize
          });
      return (response.data as List)
          .map((item) => MyMasjidList.fromJson(item))
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
