import '../models/status_rumah.dart';

abstract class StatusRumahDatasource {
  Future<List<StatusRumah>> getStatusRumahList(String statusRumahId);
}
