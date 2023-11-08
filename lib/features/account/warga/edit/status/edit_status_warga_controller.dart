import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../commons/result.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/status_baca/data/datasources/status_baca_datasource.dart';
import '../../../../shared/status_baca/data/models/status_baca.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/models/warga.dart';

class EditStatusWargaController extends GetxController {
  final AuthDatasource authDatasource;
  final UserDatasource userDatasource;
  final StatusBacaDatasource statusBacaDatasource;

  EditStatusWargaController(
      this.authDatasource, this.userDatasource, this.statusBacaDatasource);

  final _statusBacaList = Result.success(<StatusBaca>[]).obs;

  Result<List<StatusBaca>> get statusBacaList => _statusBacaList.value;

  final wargaData = {}.obs;
  final tempWargaData = {}.obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final formGlobalKeyStatus = GlobalKey<FormState>();
  late Warga warga;
  late DateTime birthDate;

  void onChangeWargaIntField(String key, int value) {
    tempWargaData[key] = value;
  }

  void onChangeWargaStringField(String key, String value) {
    tempWargaData[key] = value;
  }

  void onChangeBooleanField(String key, bool? value) {
    tempWargaData[key] = value;
  }

  void onTapBackButton() {
    Get.back();
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  void _fetchStatusBacaList() async {
    try {
      _statusBacaList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var statusBacaList =
          await statusBacaDatasource.getStatusBacaList(userInfo!.negaraId);
      _statusBacaList.value = Result.success(statusBacaList);
    } catch (e) {
      _statusBacaList.value = Result.error(e.toString());
    }
  }

  void onTapSaveStatus() async {
    if (formGlobalKeyStatus.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var userInfo = authDatasource.getUserInfo();
        await userDatasource.editWargaStatus(
            tempWargaData['wargaid'],
            tempWargaData['statusBacaId'],
            tempWargaData['isHaji'],
            userInfo!.userId);
        _isLoading.value = false;
        Get.back(result: true);
      } catch (error) {
        _isLoading.value = false;
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'An error occurred',
            message: 'Please try again');
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    warga = Get.arguments;

    wargaData.value = {
      'wargaid': warga.wargaId,
      'statusBacaId': warga.statusBacaAlquranId,
      'isHaji': warga.isHaji,
    };

    tempWargaData.addAll(wargaData);

    _fetchStatusBacaList();
  }
}
