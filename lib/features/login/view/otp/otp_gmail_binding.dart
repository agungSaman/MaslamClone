import 'package:get/get.dart';

import '../../../../consts/binding_const.dart';
import '../../data/datasources/auth_datasource.dart';
import 'otp_gmail_controller.dart';

class OtpGmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OtpGmailController(Get.find<AuthDatasource>(tag: defaultAuthTag)));
  }
}
