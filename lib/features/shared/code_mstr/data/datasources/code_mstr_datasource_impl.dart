import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/code_mstr.dart';
import 'code_mstr_datasource.dart';

class CodeMstrDatasourceImpl extends CodeMstrDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  CodeMstrDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<CodeMstr> getCodeMstrDefault(int entityId, String codeField) async {
    try {
      var response = await dio.get('api/GetMasterData/GetCodeMstrDefault',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'en_id': entityId, 'code_field': codeField});
      return CodeMstr.fromJson(response.data);
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
  Future<List<CodeMstr>> getCodeMstr(int entityId, String codeField) async {
    try {
      var response = await dio.get('api/GetMasterData/GetCodeMstr',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'en_id': entityId, 'code_field': codeField});
      return (response.data as List)
          .map((item) => CodeMstr.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
