import 'package:get/get.dart';

import '../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';
import 'password_auth_controller.dart';

class PasswordAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        PasswordAuthController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
