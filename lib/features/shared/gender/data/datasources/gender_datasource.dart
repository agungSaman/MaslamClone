import '../models/gender.dart';

abstract class GenderDatasource {
  Future<List<Gender>> getJKList(String negaraId);
}
