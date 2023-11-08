import '../../../informasimasjid/data/models/masjid_list.dart';
import '../models/banner_list.dart';
import '../models/nearest_pray_time.dart';
import '../models/pray_time.dart';

abstract class HomeTabDatasource {
  Future<NearestPrayTime> getNearestPrayTime(
      double latitude, double longitude, DateTime tanggal);

  Future<PrayTime> getPrayTime(
      double latitude, double longitude, DateTime tanggal);

  Future<List<MasjidList>> getNearestMosque(
      double latitude, double longitude, int page, int pageSize);

  Future<List<BannerList>> getBannerList(String? negaraId);
}
