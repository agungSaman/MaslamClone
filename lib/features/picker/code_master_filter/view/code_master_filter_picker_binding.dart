import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../data/datasources/code_master_filter_picker_datasource.dart';
import '../data/datasources/code_master_filter_picker_datasource_impl.dart';
import 'code_master_filter_picker_controller.dart';

class CodeMasterFilterPickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CodeMasterFilterPickerDatasource>(
        CodeMasterFilterPickerDatasourceImpl(
            Get.find<Dio>(tag: defaultNetworkTag),
            Get.find<AuthDatasource>(tag: defaultAuthTag)));
    Get.put(
        CodeMasterFilterPickerController(
            Get.find<AuthDatasource>(tag: defaultAuthTag),
            'Data',
            Get.find<CodeMasterFilterPickerDatasource>()),
        tag: 'data');
  }
}
