import '../models/pendidikan.dart';

abstract class PendidikanDatasource {
  Future<List<Pendidikan>> getPendidikanList(String negaraId);
}
