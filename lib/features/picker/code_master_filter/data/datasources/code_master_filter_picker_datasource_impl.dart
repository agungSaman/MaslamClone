import 'package:dio/dio.dart';

import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../models/pickable_code_master_filter.dart';
import 'code_master_filter_picker_datasource.dart';

class CodeMasterFilterPickerDatasourceImpl
    extends CodeMasterFilterPickerDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  CodeMasterFilterPickerDatasourceImpl(this.dio, this.authDatasource);

  @override
  Future<List<PickableCodeMasterFilter>> getPickableList(
      int entityId, String codeField, int page, int size, String query) async {
    try {
      var response = await dio.get('api/GetMasterData/GetCodeMstrFilter',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'en_id': entityId,
            'code_field': codeField,
            'offset': page,
            'limit': size,
            'code_name': query
          });
      return (response.data as List)
          .map((item) => PickableCodeMasterFilter.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
