import 'package:get/get.dart';

import 'photo_preview_controller.dart';

class PhotoPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PhotoPreviewController());
  }
}
