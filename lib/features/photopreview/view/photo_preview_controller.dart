import 'package:get/get.dart';

class PhotoPreviewController extends GetxController {
  late PhotoPreviewPageParam param;

  void onTapCloseButton() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();

    param = Get.arguments;
  }
}

class PhotoPreviewPageParam {
  final String? imageUrl;
  final String? description;
  PhotoPreviewPageParam({this.imageUrl, this.description});
}
