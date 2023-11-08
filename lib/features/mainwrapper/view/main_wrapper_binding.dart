import 'package:get/get.dart';

import '../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';
import 'main_wrapper_controller.dart';

class MainWrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        MainWrapperController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
