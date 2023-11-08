import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../commons/app_exception.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../models/warga.dart';
import 'user_datasource.dart';

class UserDatasourceImpl extends UserDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  UserDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<bool> changePassword(String currentPassword, String newPassword,
      String userId, String email) async {
    try {
      await dio.put('api/Login',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'current_pass': currentPassword,
            'new_pass': newPassword,
            'userid': userId,
            'email': email
          });
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<Warga> readWargaByUserId(String userId) async {
    try {
      var response = await dio.get('api/Warga/ReadWargaByUserId',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {'userId': userId});
      return Warga.fromJson(response.data);
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
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
      String updby) async {
    try {
      var params = {
        'warga_id': wargaid,
        'nama': nama,
        'jenis_kelamin_id': jkId,
        'tempat_lahir': tempatLahir,
        'tgl_lahir': tglLahir,
        'alamat_rumah': alamat,
        'status_rumah_id': statusRumahId,
        'tahun_domisili': tinggalSejak,
        'golongan_darah': goldar,
        'daerah_asal': daerahAsal,
        'no_ktp': noKtp,
        'updated_by': updby
      };
      await dio.put('api/Warga/UpdateWargaProfil',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          data: jsonEncode(params));
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
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
      String updby) async {
    try {
      var params = {
        'warga_id': wargaid,
        'pendidikan_id': pendidikanId,
        'pekerjaan_id': pekerjaanId,
        'pekerjaan_lain': pekerjaanLain,
        'nama_perusahaan': namaPerusahaan,
        'jenis_usaha': jenisUsaha,
        'keahlian': keahlian,
        'penghasilan_id': penghasilanId,
        'jumlah_tanggungan': tanggungan,
        'updated_by': updby
      };

      await dio.put('api/Warga/UpdateWargaProfesional',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          data: jsonEncode(params));
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<bool> editWargaStatus(
      String wargaid, String statusBacaId, bool isHaji, String updby) async {
    try {
      var params = {
        'warga_id': wargaid,
        'status_baca_alquran_id': statusBacaId,
        'is_haji': isHaji,
        'updated_by': updby
      };

      await dio.put('api/Warga/UpdateWargaStatus',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          data: jsonEncode(params));
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<bool> editWargaAlamatTelepon(
      String userId, String nama, String noHp, String alamat) async {
    try {
      await dio.put('api/Warga/UpdateKelengkapanWarga',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          queryParameters: {
            'userId': userId,
            'nama': nama,
            'noHp': noHp,
            'alamat': alamat
          });
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<bool> requestJamaahMasjid(String userid, String masjidId) async {
    try {
      var params = {
        'created_by': userid,
        'user_id': userid,
        'masjid_id': masjidId
      };
      await dio.post('api/Jamaah/CreateRequestJamaah',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          data: jsonEncode(params));
      return true;
    } on DioException catch (error) {
      if (error.response!.statusCode == 404) {
        throw UserNotFoundException();
      }
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }

  @override
  Future<bool> uploadPhotoAccount(
      String userId, String nama, XFile? imagePath) async {
    try {
      if (imagePath == null) return false;
      String fileName = imagePath.path.split('/').last;

      await dio.post('api/Warga/UploadFotoWarga',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          data: FormData.fromMap({
            'userId': userId,
            'name': nama,
            'files': await MultipartFile.fromFile(imagePath.path,
                filename: fileName),
            'extension': 'jpg',
          }));
      return true;
    } on DioException catch (error) {
      throw GeneralException(error.toString());
    } catch (error, stackTrace) {
      debugPrint('${error.toString()}\n${stackTrace.toString()}');
      throw GeneralException(stackTrace.toString());
    }
  }
}
