import '../models/kegiatan.dart';

abstract class KegiatanDatasource {
  Future<List<Kegiatan>> getKegiatanMaster(String negaraId);
}
