import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../data/datasources/auth_datasource.dart';
import 'signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
