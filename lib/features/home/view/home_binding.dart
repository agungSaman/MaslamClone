import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../mainwrapper/view/main_wrapper_controller.dart';
import '../data/datasources/administrative_tools_datasource.dart';
import '../data/datasources/administrative_tools_datasource_impl.dart';
import '../data/datasources/home_tab_datasource.dart';
import '../data/datasources/home_tab_datasource_impl.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdministrativeToolsDatasource>(AdministrativeToolsDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<HomeTabDatasource>(HomeTabDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(HomeController(
        Get.find<AdministrativeToolsDatasource>(),
        Get.find<HomeTabDatasource>(),
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<MainWrapperController>()));
  }
}
