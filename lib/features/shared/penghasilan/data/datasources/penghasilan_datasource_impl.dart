import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/penghasilan.dart';
import 'penghasilan_datasource.dart';

class PenghasilanDatasourceImpl extends PenghasilanDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  PenghasilanDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<Penghasilan>> getPenghasilanList(String negaraId) async {
    try {
      var response = await dio.get('api/Penghasilan/ReadPenghasilan',
          // options: Options(headers: {
          //   'Authorization': 'Bearer ${await authDatasource.getToken()}'
          // }),
          queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => Penghasilan.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
