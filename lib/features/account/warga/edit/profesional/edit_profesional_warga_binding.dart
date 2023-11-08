import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../../consts/binding_const.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/pekerjaan/data/datasources/pekerjaan_datasource.dart';
import '../../../../shared/pekerjaan/data/datasources/pekerjaan_datasource_impl.dart';
import '../../../../shared/pendidikan/data/datasources/pendidikan_datasource.dart';
import '../../../../shared/pendidikan/data/datasources/pendidikan_datasource_impl.dart';
import '../../../../shared/penghasilan/data/datasources/penghasilan_datasource.dart';
import '../../../../shared/penghasilan/data/datasources/penghasilan_datasource_impl.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/datasources/user_datasource_impl.dart';
import 'edit_profesional_warga_controller.dart';

class EditProfesionalWargaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<PekerjaanDatasource>(PekerjaanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<PendidikanDatasource>(PendidikanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<PenghasilanDatasource>(PenghasilanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(EditProfesionalWargaController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<UserDatasource>(),
      Get.find<PekerjaanDatasource>(),
      Get.find<PendidikanDatasource>(),
      Get.find<PenghasilanDatasource>(),
    ));
  }
}
