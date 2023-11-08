import 'package:camera/camera.dart' as camera_lib;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../commons/result.dart';
import 'camera_controller.dart';

class CameraPage extends GetView<CameraController> {
  static const routeName = '/camera';

  const CameraPage({Key? key}) : super(key: key);

  Widget camera() => Container(
      color: const Color.fromRGBO(52, 52, 52, 1.0),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.face,
            size: 36,
            color: Colors.white,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Make sure your face visible on the camera',
            textAlign: TextAlign.center,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: AspectRatio(
                    aspectRatio: 5 / 9,
                    child:
                        camera_lib.CameraPreview(controller.cameraController)),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Obx(() => controller.attendanceResult.status == Status.error ||
                  (controller.attendanceResult.status == Status.success &&
                      !controller.attendanceResult.data!)
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 14,
                          color: Color.fromRGBO(255, 129, 166, 1.0),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          controller.attendanceResult.status ==
                                      Status.success &&
                                  !controller.attendanceResult.data!
                              ? 'You are not in the office area'
                              : 'There\'s a problem processing data',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                )
              : const SizedBox()),
          SizedBox(
            width: double.infinity,
            child: TextButton(
                onPressed: controller.attendanceResult.status != Status.loading
                    ? controller.onTapCaptureButton
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      controller.attendanceResult.status == Status.loading
                          ? Colors.grey.withOpacity(0.5)
                          : const Color.fromRGBO(98, 98, 98, 1.0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
                ),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Obx(
                      () => controller.attendanceResult.status == Status.loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              'Take Picture',
                              style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                    ))),
          )
        ]),
      )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isCameraReady &&
              controller.cameraController.value.isInitialized
          ? camera()
          : Container(
              color: Colors.black,
            )),
    );
  }
}
