import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/user_datasource.dart';
import '../../data/datasources/user_datasource_impl.dart';
import 'warga_controller.dart';

class WargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(WargaController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<UserDatasource>(),
    ));
  }
}
