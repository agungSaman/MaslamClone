import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/informasi_kegiatan_datasource.dart';
import '../../data/datasources/informasi_kegiatan_datasource_impl.dart';
import 'informasi_kegiatan_detail_controller.dart';

class InformasiKegiatanDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InformasiKegiatanDatasource>(InformasiKegiatanDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(InformasiKegiatanDetailController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<InformasiKegiatanDatasource>(),
    ));
  }
}
