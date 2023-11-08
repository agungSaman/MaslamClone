import '../models/status_baca.dart';

abstract class StatusBacaDatasource {
  Future<List<StatusBaca>> getStatusBacaList(String negaraId);
}
