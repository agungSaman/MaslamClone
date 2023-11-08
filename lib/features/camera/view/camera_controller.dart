import 'dart:io';

import 'package:camera/camera.dart' as camera_lib;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../commons/result.dart';
import '../../../utils/date_formatter.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../shared/helper/data/datasources/helper_datasource.dart';
import '../../shared/user/data/models/user.dart';

class CameraController extends SuperController {
  final _isCameraReady = false.obs;

  /// Result.success(true) if user is in office coverage
  /// Result.success(false) if user is not in office coverage
  /// Result.error(error) if either permission is denied or other error
  final _attendanceResult = Result.success(true).obs;

  final AuthDatasource _authDatasource;
  final HelperDatasource _helperDatasource;

  CameraController(this._authDatasource, this._helperDatasource);

  bool get isCameraReady => _isCameraReady.value;

  Result<bool> get attendanceResult => _attendanceResult.value;
  late camera_lib.CameraDescription camera;
  late camera_lib.CameraController cameraController;

  late User userData;

  late LocationData? currentUserLocationData;

  late DateTime currentDateTime;

  void onTapCaptureButton() async {
    try {
      _attendanceResult.value = Result.loading();
      var currentDateTimeString = await _helperDatasource.getServerDateTime();
      currentDateTime = currentDateTimeString.dateTime;

      await cameraController.initialize();

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final imagePath = await cameraController.takePicture();
      _attendanceResult.value = Result.loading();

      // delete image after it has been sent to backend
      // to save memory
      await deleteFile(File(imagePath.path));
      _attendanceResult.value = Result.success(true);

      Get.back(result: true);
    } catch (e) {
      debugPrint(e.toString());
      _attendanceResult.value = Result.error(e.toString());
    }
  }

  Future<void> deleteFile(File file) async {
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  void onInit() async {
    super.onInit();

    userData = _authDatasource.getUserInfo()!;
    var cameraList = await camera_lib.availableCameras();
    debugPrint(cameraList.toString());
    camera = cameraList[1];

    cameraController = camera_lib.CameraController(
      camera,
      camera_lib.ResolutionPreset.max,
    );
    await cameraController.initialize();
    _isCameraReady.value = true;
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {
    cameraController.dispose();
  }

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
