import 'package:get/get.dart';

import '../../../consts/binding_const.dart';
import '../data/datasources/auth_datasource.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
