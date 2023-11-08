import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/informasi_masjid_datasource.dart';
import '../../data/datasources/informasi_masjid_datasource_impl.dart';
import 'informasi_masjid_detail_controller.dart';

class InformasiMasjidDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InformasiMasjidDatasource>(InformasiMasjidDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(InformasiMasjidDetailController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<InformasiMasjidDatasource>(),
    ));
  }
}
