import '../models/my_masjid_list.dart';

abstract class MyMasjidDatasource {
  Future<List<MyMasjidList>> readMyMasjidList(String userId, double latitude,
      double longitude, String cari, int page, int pageSize);
}
