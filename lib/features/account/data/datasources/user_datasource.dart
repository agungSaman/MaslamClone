import 'package:image_picker/image_picker.dart';

import '../models/warga.dart';

abstract class UserDatasource {
  Future<bool> changePassword(
      String currentPassword, String newPassword, String userId, String email);

  Future<Warga> readWargaByUserId(String userId);

  Future<bool> editWargaProfil(
      String wargaid,
      String nama,
      String jkId,
      String tempatLahir,
      String tglLahir,
      String alamat,
      String statusRumahId,
      String tinggalSejak,
      String goldar,
      String daerahAsal,
      String noKtp,
      String updby);

  Future<bool> editWargaProfesional(
      String wargaid,
      String pendidikanId,
      String pekerjaanId,
      String pekerjaanLain,
      String namaPerusahaan,
      String jenisUsaha,
      String keahlian,
      String penghasilanId,
      int tanggungan,
      String updby);

  Future<bool> editWargaStatus(
      String wargaid, String statusBacaId, bool isHaji, String updby);

  Future<bool> editWargaAlamatTelepon(
      String userId, String nama, String noHp, String alamat);

  Future<bool> requestJamaahMasjid(String userid, String masjidId);

  Future<bool> uploadPhotoAccount(String userId, String nama, XFile? imagePath);
}
