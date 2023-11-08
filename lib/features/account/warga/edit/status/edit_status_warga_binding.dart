import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../../consts/binding_const.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/status_baca/data/datasources/status_baca_datasource.dart';
import '../../../../shared/status_baca/data/datasources/status_baca_datasource_impl.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/datasources/user_datasource_impl.dart';
import 'edit_status_warga_controller.dart';

class EditStatusWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<StatusBacaDatasource>(StatusBacaDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(EditStatusWargaController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<UserDatasource>(),
      Get.find<StatusBacaDatasource>(),
    ));
  }
}
