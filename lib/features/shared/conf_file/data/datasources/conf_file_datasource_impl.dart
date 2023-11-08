import 'package:dio/dio.dart';

import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import 'conf_file_datasource.dart';

class ConfFileDatasourceImpl extends ConfFileDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  ConfFileDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<int> getConfFile(String confName) async {
    try {
      var response = await dio.get('api/GetMasterData/GetConfFile',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'conf_name': confName});
      return int.parse(response.data);
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
