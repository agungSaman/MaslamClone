import '../models/pekerjaan.dart';

abstract class PekerjaanDatasource {
  Future<List<Pekerjaan>> getPekerjaanList(String negaraId);
}
