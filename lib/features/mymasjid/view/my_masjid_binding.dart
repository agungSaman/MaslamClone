import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../data/datasources/my_masjid_datasource.dart';
import '../data/datasources/my_masjid_datasource_impl.dart';
import 'my_masjid_controller.dart';

class MyMasjidBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyMasjidDatasource>(MyMasjidDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(MyMasjidController(
      Get.find<AuthDatasource>(tag: defaultAuthTag),
      Get.find<MyMasjidDatasource>(),
    ));
  }
}
