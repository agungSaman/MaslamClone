import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../commons/app_exception.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../models/informasi_kegiatan.dart';
import '../models/kegiatan_banner_list_model.dart';
import '../models/pembicara_model.dart';
import 'informasi_kegiatan_datasource.dart';

class InformasiKegiatanDatasourceImpl extends InformasiKegiatanDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  InformasiKegiatanDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<List<InformasiKegiatan>> getKegiatanByMasjidTerdekat(
      double latitude,
      double longitude,
      String kategori,
      String cari,
      int page,
      int pageSize) async {
    try {
      var response = await dio
          .get('api/Kegiatan/ReadKegiatanByMasjidTerdekat', queryParameters: {
        'myLatitude': latitude,
        'myLongitude': longitude,
        'kategori': kategori,
        'pencarian': cari,
        'page': page,
        'pageSize': pageSize
      });
      return (response.data as List)
          .map((item) => InformasiKegiatan.fromJson(item))
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
  Future<List<InformasiKegiatan>> getKegiatanByMasjidFavorit(String userId,
      String kategori, String cari, int page, int pageSize) async {
    try {
      var response = await dio.get('api/Kegiatan/ReadKegiatanByMasjidFavorit',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'user_id': userId,
            'kategori': kategori,
            'pencarian': cari,
            'page': page,
            'pageSize': pageSize
          });
      return (response.data as List)
          .map((item) => InformasiKegiatan.fromJson(item))
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
  Future<List<InformasiKegiatan>> getKegiatanByMasjidJamaah(
      String kategori, String cari, int page, int pageSize) async {
    try {
      var response = await dio.get('api/Kegiatan/ReadKegiatanByMasjidJamaah',
          options: Options(headers: {
            'Authorization': 'Bearer ${await authDatasource.getToken()}'
          }),
          queryParameters: {
            'kategori': kategori,
            'pencarian': cari,
            'page': page,
            'pageSize': pageSize
          });
      return (response.data as List)
          .map((item) => InformasiKegiatan.fromJson(item))
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
  Future<InformasiKegiatan> readKegiatanById(String kegiatanId) async {
    try {
      var response = await dio.get('/api/Kegiatan/ReadKegiatanByIdMobileApps',
          queryParameters: {'kegiatanId': kegiatanId});
      return InformasiKegiatan.fromJson(response.data);
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
  Future<List<KegiatanBannerListModel>> getKegiatanBannerUrlList(
      String kegiatanId) async {
    try {
      var response = await dio.get('api/Kegiatan/GetKegiatanBannerUrlList',
          queryParameters: {'kegiatanId': kegiatanId});
      return (response.data as List)
          .map((item) => KegiatanBannerListModel.fromJson(item))
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
  Future<List<PembicaraModel>> readKegiatanPembicaraById(
      String kegiatanId) async {
    try {
      var response = await dio.get('api/Kegiatan/ReadKegiatanPembicaraById',
          queryParameters: {'kegiatanId': kegiatanId});
      return (response.data as List)
          .map((item) => PembicaraModel.fromJson(item))
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
}
