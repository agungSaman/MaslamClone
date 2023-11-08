import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../shared/master/kegiatan/datasources/kegiatan_datasource.dart';
import '../../shared/master/kegiatan/datasources/kegiatan_datasource_impl.dart';
import '../data/datasources/informasi_kegiatan_datasource.dart';
import '../data/datasources/informasi_kegiatan_datasource_impl.dart';
import 'informasi_kegiatan_controller.dart';

class InformasiKegiatanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InformasiKegiatanDatasource>(InformasiKegiatanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<KegiatanDatasource>(KegiatanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(InformasiKegiatanController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<InformasiKegiatanDatasource>(),
      Get.find<KegiatanDatasource>(),
    ));
  }
}
