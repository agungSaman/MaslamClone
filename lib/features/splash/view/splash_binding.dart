import 'package:get/get.dart';
import '../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';

import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
