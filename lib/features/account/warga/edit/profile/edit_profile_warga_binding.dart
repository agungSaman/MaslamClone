import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../../consts/binding_const.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/gender/data/datasources/gender_datasource.dart';
import '../../../../shared/gender/data/datasources/gender_datasource_impl.dart';
import '../../../../shared/status_rumah/data/datasources/status_rumah_datasource.dart';
import '../../../../shared/status_rumah/data/datasources/status_rumah_datasource_impl.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/datasources/user_datasource_impl.dart';
import 'edit_profile_warga_controller.dart';

class EditProfileWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<GenderDatasource>(GenderDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<StatusRumahDatasource>(StatusRumahDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(EditProfileWargaController(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<UserDatasource>(),
        Get.find<GenderDatasource>(),
        Get.find<StatusRumahDatasource>()));
  }
}
