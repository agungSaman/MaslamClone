import '../models/penghasilan.dart';

abstract class PenghasilanDatasource {
  Future<List<Penghasilan>> getPenghasilanList(String negaraId);
}
