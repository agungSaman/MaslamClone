import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../models/kegiatan.dart';
import 'kegiatan_datasource.dart';

class KegiatanDatasourceImpl extends KegiatanDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  KegiatanDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<Kegiatan>> getKegiatanMaster(String negaraId) async {
    try {
      var response = await dio.get(
          'api/MasterKategoriKegiatan/ReadMasterKategoriKegiatanFilter',
          queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => Kegiatan.fromJson(item))
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
