import '../models/informasi_kegiatan.dart';
import '../models/kegiatan_banner_list_model.dart';
import '../models/pembicara_model.dart';

abstract class InformasiKegiatanDatasource {
  Future<List<InformasiKegiatan>> getKegiatanByMasjidTerdekat(double latitude,
      double longitude, String kategori, String cari, int page, int pageSize);

  Future<List<InformasiKegiatan>> getKegiatanByMasjidFavorit(
      String userId, String kategori, String cari, int page, int pageSize);

  Future<List<InformasiKegiatan>> getKegiatanByMasjidJamaah(
      String kategori, String cari, int page, int pageSize);

  Future<InformasiKegiatan> readKegiatanById(String kegiatanId);

  Future<List<KegiatanBannerListModel>> getKegiatanBannerUrlList(
      String kegiatanId);

  Future<List<PembicaraModel>> readKegiatanPembicaraById(String kegiatanId);
}
