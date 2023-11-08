import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import 'helper_datasource.dart';

class HelperDatasourceImpl extends HelperDatasource {
  final Dio dio;
  final AuthDatasource authDatasource;

  HelperDatasourceImpl(this.dio, this.authDatasource);

  @override
  Future<String> getServerDateTime() async {
    try {
      var response = await dio.get(
        'api/GetHelperData/GetDateTime',
        options: Options(headers: {
          'Authorization': 'Bearer ${await authDatasource.getToken()}'
        }),
      );
      return response.data;
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
