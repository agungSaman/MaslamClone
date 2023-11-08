import '../models/currency_list.dart';

abstract class CurrencyListDatasource {
  Future<List<CurrencyList>> getCurrencyList();
}
