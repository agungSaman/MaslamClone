import 'package:get/get.dart';
import '../../../consts/binding_const.dart';
import '../../login/data/datasources/auth_datasource.dart';

import '../../shared/helper/data/datasources/helper_datasource.dart';
import 'camera_controller.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CameraController(Get.find<AuthDatasource>(tag: defaultAuthTag),
        Get.find<HelperDatasource>()));
  }
}
