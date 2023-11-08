import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import 'logout_controller.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LogoutController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
