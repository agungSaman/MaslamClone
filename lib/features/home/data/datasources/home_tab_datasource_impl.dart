// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../commons/app_exception.dart';
import '../../../../utils/date_formatter.dart';
import '../../../informasimasjid/data/models/masjid_list.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../models/banner_list.dart';
import '../models/nearest_pray_time.dart';
import '../models/pray_time.dart';
import 'home_tab_datasource.dart';

class HomeTabDatasourceImpl extends HomeTabDatasource {
  final AuthDatasource authDatasource;
  final Dio dio;

  HomeTabDatasourceImpl(this.authDatasource, this.dio);

  @override
  Future<NearestPrayTime> getNearestPrayTime(
      double latitude, double longitude, DateTime tanggal) async {
    try {
      var response = await dio.get('api/Sholat/ReadNearestPraytime',
          queryParameters: {
            'latitude': latitude,
            'longitude': longitude,
            'tanggalWaktuSekarang': tanggal
          });
      return NearestPrayTime.fromJson(response.data);
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
  Future<PrayTime> getPrayTime(
      double latitude, double longitude, DateTime tanggal) async {
    try {
      var response = await dio.get('api/Sholat/ReadPraytime', queryParameters: {
        'latitude': latitude,
        'longitude': longitude,
        'tanggalWaktuSekarang': tanggal
      });
      return PrayTime.fromJson(response.data);
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
  Future<List<MasjidList>> getNearestMosque(
      double latitude, double longitude, int page, int pageSize) async {
    try {
      var response =
          await dio.get('api/Masjid/ReadNearestMasjid', queryParameters: {
        'myLatitude': latitude,
        'myLongitude': longitude,
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
  Future<List<BannerList>> getBannerList(String? negaraId) async {
    try {
      var response = await dio.get('api/Banner/GetBannerUrlList',
          queryParameters: {'negaraId': negaraId});
      return (response.data as List)
          .map((item) => BannerList.fromJson(item))
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
