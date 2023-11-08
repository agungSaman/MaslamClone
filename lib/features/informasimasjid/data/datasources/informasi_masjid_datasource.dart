import '../models/masjid_banner_list.dart';
import '../models/masjid_description.dart';
import '../models/masjid_detail.dart';
import '../models/masjid_fasilitas.dart';
import '../models/masjid_kegiatan.dart';
import '../models/masjid_kontak.dart';
import '../models/masjid_list.dart';
import '../models/masjid_pengurus.dart';

abstract class InformasiMasjidDatasource {
  Future<List<MasjidList>> getMasjidList(
      double latitude, double longitude, String cari, int page, int pageSize);

  Future<MasjidDetail> getMasjidDetail(String masjidId);

  Future<MasjidDetail> getUserMasjidDetail(String masjidId, String userId);

  Future<List<MasjidBannerList>> getMasjidBannerList(String? masjidId);

  Future<MasjidDescription> getMasjidDescription(String masjidId);

  Future<List<MasjidPengurus>> getMasjidPengurus(String? masjidId);

  Future<List<MasjidKontak>> getMasjidKontak(String? masjidId);

  Future<List<MasjidFasilitas>> getMasjidFasilitas(String? masjidId);

  Future<List<MasjidKegiatan>> getMasjidKegiatan(String? masjidId);

  Future<bool> createMasjidFavorit(
      String userid, String namaUser, String masjidId, String masjidNama);

  Future<bool> deleteMasjidFavorit(
      String userid, String namaUser, String masjidId, String masjidNama);

  Future<bool> requestJamaahMasjid(String userid, String masjidId);

  Future<bool> createMasjidLike(
      String userid, String namaUser, String masjidId, String masjidNama);

  Future<bool> deleteMasjidLike(
      String userid, String namaUser, String masjidId, String masjidNama);
}
