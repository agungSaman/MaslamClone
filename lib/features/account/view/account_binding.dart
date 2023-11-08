import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../consts/binding_const.dart';
import '../../account/data/datasources/user_datasource.dart';
import '../../account/data/datasources/user_datasource_impl.dart';
import '../../login/data/datasources/auth_datasource.dart';
import 'account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserDatasourceImpl(Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put<UserDatasource>(UserDatasourceImpl(
        Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<Dio>(tag: defaultNetworkTag)));
    Get.put(AccountController(Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<UserDatasourceImpl>()));
  }
}
