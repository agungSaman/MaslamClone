// ignore_for_file: unused_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../commons/app_exception.dart';
import '../../../../utils/date_formatter.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../models/masjid_banner_list.dart';
import '../models/masjid_description.dart';
import '../models/masjid_detail.dart';
import '../models/masjid_fasilitas.dart';
import '../models/masjid_kegiatan.dart';
import '../models/masjid_kontak.dart';
import '../models/masjid_list.dart';
import '../models/masjid_pengurus.dart';
import 'informasi_masjid_datasource.dart';

class InformasiMasjidDatasourceImpl extends InformasiMasjidDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  InformasiMasjidDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<MasjidList>> getMasjidList(double latitude, double longitude,
      String cari, int page, int pageSize) async {
    try {
      var response =
          await dio.get('api/Masjid/ReadNearestMasjid', queryParameters: {
        'myLatitude': latitude,
        'myLongitude': longitude,
        'cari': cari,
        'page': page,
        'pageSize': pageSize
      });
      return (response.data as List)
          .map((item) => MasjidList.fromJson(item))
          .toList();
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
  Future<MasjidDetail> getMasjidDetail(String masjidId) async {
    try {
      var response = await dio.get('/api/Masjid/ReadMasjidById',
          queryParameters: {'masjidId': masjidId});
      return MasjidDetail.fromJson(response.data);
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
  Future<MasjidDetail> getUserMasjidDetail(
      String masjidId, String userId) async {
    try {
      var response = await dio.get('/api/Masjid/ReadMasjidByUserId',
          queryParameters: {'masjidId': masjidId, 'userId': userId});
      return MasjidDetail.fromJson(response.data);
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
  Future<List<MasjidBannerList>> getMasjidBannerList(String? masjidId) async {
    try {
      var response = await dio.get('api/Masjid/GetMasjidBannerUrlList',
          queryParameters: {'masjidId': masjidId});
      return (response.data as List)
          .map((item) => MasjidBannerList.fromJson(item))
          .toList();
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
  Future<MasjidDescription> getMasjidDescription(String masjidId) async {
    try {
      var response = await dio.get('api/Masjid/ReadDescriptionMasjidById',
          queryParameters: {'masjidId': masjidId});
      return MasjidDescription.fromJson(response.data);
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
  Future<List<MasjidPengurus>> getMasjidPengurus(String? masjidId) async {
    try {
      var response = await dio.get('api/Masjid/ReadPengurusMasjidById',
          queryParameters: {'masjidId': masjidId});
      return (response.data as List)
          .map((item) => MasjidPengurus.fromJson(item))
          .toList();
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
  Future<List<MasjidKontak>> getMasjidKontak(String? masjidId) async {
    try {
      var response = await dio.get('api/Masjid/ReadKontakMasjidById',
          queryParameters: {'masjidId': masjidId});
      return (response.data as List)
          .map((item) => MasjidKontak.fromJson(item))
          .toList();
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
  Future<List<MasjidFasilitas>> getMasjidFasilitas(String? masjidId) async {
    try {
      var response = await dio.get('api/Masjid/ReadFasilitasMasjidById',
          queryParameters: {'masjidId': masjidId});
      return (response.data as List)
          .map((item) => MasjidFasilitas.fromJson(item))
          .toList();
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
  Future<List<MasjidKegiatan>> getMasjidKegiatan(String? masjidId) async {
    try {
      var response = await dio.get('api/Masjid/ReadKategoriKegiatanMasjidById',
          queryParameters: {'masjidId': masjidId});
      return (response.data as List)
          .map((item) => MasjidKegiatan.fromJson(item))
          .toList();
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
  Future<bool> createMasjidFavorit(String userid, String namaUser,
      String masjidId, String masjidNama) async {
    try {
      var uuid = const Uuid();
      var params = {
        'user_masjid_fav_id': uuid.v4().toString(),
        'created_by': userid,
        'created_name': namaUser,
        'user_id': userid,
        'masjid_id': masjidId,
        'masjid_nama': masjidNama
      };

      await dio.post('api/Masjid/CreateMasjidFavorit',
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
  Future<bool> deleteMasjidFavorit(String userid, String namaUser,
      String masjidId, String masjidNama) async {
    try {
      await dio.delete('api/Masjid/DeleteMasjidFavoritByUserId',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          queryParameters: {
            'masjidId': masjidId,
            'namaMasjid': masjidNama,
            'userId': userid,
            'userName': namaUser,
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
  Future<bool> createMasjidLike(String userid, String namaUser, String masjidId,
      String masjidNama) async {
    try {
      var uuid = const Uuid();
      var params = {
        'user_masjid_like_id': uuid.v4().toString(),
        'created_by': userid,
        'created_name': namaUser,
        'user_id': userid,
        'masjid_id': masjidId,
        'masjid_nama': masjidNama
      };

      await dio.post('api/Masjid/CreateMasjidLike',
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
  Future<bool> deleteMasjidLike(String userid, String namaUser, String masjidId,
      String masjidNama) async {
    try {
      await dio.delete('api/Masjid/DeleteMasjidLikeByUserId',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}',
          }),
          queryParameters: {
            'masjidId': masjidId,
            'namaMasjid': masjidNama,
            'userId': userid,
            'userName': namaUser,
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
}
