import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/address_type.dart';
import 'address_type_datasource.dart';

class AddressTypeDatasourceImpl extends AddressTypeDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  AddressTypeDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<AddressType>> getAddressTypeList(int entityId) async {
    try {
      var response = await dio.get('api/GetMasterDataHR/GetCodeMstr',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'en_id': entityId, 'code_field': 'emp_addr_type'});
      return (response.data as List)
          .map((item) => AddressType.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
