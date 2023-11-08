import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/status_rumah.dart';
import 'status_rumah_datasource.dart';

class StatusRumahDatasourceImpl extends StatusRumahDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  StatusRumahDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<StatusRumah>> getStatusRumahList(String statusRumahId) async {
    try {
      var response = await dio.get('api/StatusRumah/ReadStatusRumah',
          // options: Options(headers: {
          //   'Authorization': 'Bearer ${await authDatasource.getToken()}'
          // }),
          queryParameters: {'negaraId': statusRumahId});
      return (response.data as List)
          .map((item) => StatusRumah.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
