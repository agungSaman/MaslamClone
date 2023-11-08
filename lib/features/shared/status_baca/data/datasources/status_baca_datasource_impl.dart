import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/status_baca.dart';
import 'status_baca_datasource.dart';

class StatusBacaDatasourceImpl extends StatusBacaDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  StatusBacaDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<StatusBaca>> getStatusBacaList(String negaraId) async {
    try {
      var response =
          await dio.get('api/StatusBacaAlquran/ReadStatusBacaAlquran',
              // options: Options(headers: {
              //   'Authorization': 'Bearer ${await authDatasource.getToken()}'
              // }),
              queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => StatusBaca.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
