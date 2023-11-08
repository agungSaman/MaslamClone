import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/gender.dart';
import 'gender_datasource.dart';

class GenderDatasourceImpl extends GenderDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  GenderDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<Gender>> getJKList(String negaraId) async {
    try {
      var response = await dio.get('api/JenisKelamin/ReadJenisKelamin',
          // options: Options(headers: {
          //   'Authorization': 'Bearer ${await authDatasource.getToken()}'
          // }),
          queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => Gender.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
