import '../models/code_mstr.dart';

abstract class CodeMstrDatasource {
  Future<CodeMstr> getCodeMstrDefault(int entityId, String codeField);
  Future<List<CodeMstr>> getCodeMstr(int entityId, String codeField);
}
