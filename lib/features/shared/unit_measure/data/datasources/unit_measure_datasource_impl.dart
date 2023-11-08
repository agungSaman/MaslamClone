import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../user/data/models/user.dart';
import '../models/unit_measure.dart';
import 'unit_measure_datasource.dart';

class UnitMeasureDatasourceImpl extends UnitMeasureDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  UnitMeasureDatasourceImpl(this.authDatasource, this.dio);

  User get userData => authDatasource.getUserInfo()!;

  @override
  Future<List<UnitMeasure>> getUnitMeasureList() async {
    try {
      var response = await dio.get('api/GetMasterDataHR/GetCodeMstr',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'en_id': userData.negaraId,
            'code_field': 'unit_measures'
          });
      return (response.data as List)
          .map((item) => UnitMeasure.fromJson(item))
          .toList();
    } on DioException catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<UnitMeasure>> getItemUnitMeasureList() async {
    try {
      var response = await dio.get('api/GetMasterData/GetCodeMstr',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'en_id': userData.negaraId,
            'code_field': 'unitmeasure'
          });
      return (response.data as List)
          .map((item) => UnitMeasure.fromJson(item))
          .toList();
    } on DioException catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<double> getUnitMeasureConversion(int ptId, int umId) async {
    try {
      var response = await dio.get('api/GetMasterData/GetUMConversion',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'pt_id': ptId, 'um_id': umId});
      return response.data + 0.0;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<List<UnitMeasure>> getUMList(int ptId) async {
    try {
      var response = await dio.get('api/GetMasterData/GetUM',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'en_id': userData.negaraId, 'pt_id': ptId});
      return (response.data as List)
          .map((item) => UnitMeasure.fromJson(item))
          .toList();
    } on DioException catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
