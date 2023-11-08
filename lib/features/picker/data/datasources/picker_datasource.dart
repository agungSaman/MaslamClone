import '../models/pickable.dart';

abstract class PickerDatasource {
  Future<List<Pickable>> getPickableList(
      int entityId, int branchId, int page, int size, String query);
}
