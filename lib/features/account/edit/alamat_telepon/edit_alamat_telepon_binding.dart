import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/user_datasource.dart';
import '../../data/datasources/user_datasource_impl.dart';
import 'edit_alamat_telepon_controller.dart';

class EditAlamatTeleponBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(EditAlamatTeleponController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<UserDatasource>(),
    ));
  }
}
