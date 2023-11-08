import '../models/pickable_code_master_filter.dart';

abstract class CodeMasterFilterPickerDatasource {
  Future<List<PickableCodeMasterFilter>> getPickableList(
      int entityId, String codeField, int page, int size, String query);
}
