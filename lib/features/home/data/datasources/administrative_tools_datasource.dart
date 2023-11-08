import '../models/menu_feature_flag.dart';

abstract class AdministrativeToolsDatasource {
  Future<List<MenuFeatureFlag>> getMenuFeatureFlag(String userId);
  Future<List<MenuFeatureFlag>> getDashboardMenuFeatureFlag(String userId);
}
