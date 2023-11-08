import 'package:dio/dio.dart';
import '../../../../../commons/app_exception.dart';
import '../../../../login/data/datasources/auth_datasource.dart';

import '../models/currency_list.dart';
import 'currency_list_datasource.dart';

class CurrencyListDatasourceImpl extends CurrencyListDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  CurrencyListDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<CurrencyList>> getCurrencyList() async {
    try {
      var response = await dio.get('api/Currency/GetCurrency',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }));
      return (response.data as List)
          .map((item) => CurrencyList.fromJson(item))
          .toList();
    } catch (error, stackTrace) {
      throw GeneralException(stackTrace.toString());
    }
  }
}
