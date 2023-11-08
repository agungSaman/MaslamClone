import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/pendidikan.dart';
import 'pendidikan_datasource.dart';

class PendidikanDatasourceImpl extends PendidikanDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  PendidikanDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<Pendidikan>> getPendidikanList(String negaraId) async {
    try {
      var response = await dio.get('api/Pendidikan/ReadPendidikan',
          // options: Options(headers: {
          //   'Authorization': 'Bearer ${await authDatasource.getToken()}'
          // }),
          queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => Pendidikan.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
