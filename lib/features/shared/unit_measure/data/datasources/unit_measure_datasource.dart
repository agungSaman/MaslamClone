import '../models/unit_measure.dart';

abstract class UnitMeasureDatasource {
  Future<List<UnitMeasure>> getUnitMeasureList();
  Future<List<UnitMeasure>> getItemUnitMeasureList();
  Future<double> getUnitMeasureConversion(int ptId, int umId);
  Future<List<UnitMeasure>> getUMList(int ptId);
}
