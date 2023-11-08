import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../commons/result.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/pekerjaan/data/datasources/pekerjaan_datasource.dart';
import '../../../../shared/pekerjaan/data/models/pekerjaan.dart';
import '../../../../shared/pendidikan/data/datasources/pendidikan_datasource.dart';
import '../../../../shared/pendidikan/data/models/pendidikan.dart';
import '../../../../shared/penghasilan/data/datasources/penghasilan_datasource.dart';
import '../../../../shared/penghasilan/data/models/penghasilan.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/models/warga.dart';

class EditProfesionalWargaController extends GetxController {
  final AuthDatasource authDatasource;
  final UserDatasource userDatasource;
  final PekerjaanDatasource pekerjaanDatasource;
  final PendidikanDatasource pendidikanDatasource;
  final PenghasilanDatasource penghasilanDatasource;

  EditProfesionalWargaController(
    this.authDatasource,
    this.userDatasource,
    this.pekerjaanDatasource,
    this.pendidikanDatasource,
    this.penghasilanDatasource,
  );

  final _pekerjaanList = Result.success(<Pekerjaan>[]).obs;
  final _pendidikanList = Result.success(<Pendidikan>[]).obs;
  final _penghasilanList = Result.success(<Penghasilan>[]).obs;

  Result<List<Pekerjaan>> get pekerjaanList => _pekerjaanList.value;
  Result<List<Pendidikan>> get pendidikanList => _pendidikanList.value;
  Result<List<Penghasilan>> get penghasilanList => _penghasilanList.value;

  final wargaData = {}.obs;
  final tempWargaData = {}.obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final formGlobalKeyProfesional = GlobalKey<FormState>();
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

  final namaUsahaTextEditingController = TextEditingController();
  final jenisUsahaTextEditingController = TextEditingController();
  final keahlianTextEditingController = TextEditingController();
  final tanggunganTextEditingController = TextEditingController();

  void onTapBackButton() {
    Get.back();
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  void _fetchPekerjaanList() async {
    try {
      _pekerjaanList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var pekerjaanList =
          await pekerjaanDatasource.getPekerjaanList(userInfo!.negaraId);
      _pekerjaanList.value = Result.success(pekerjaanList);
    } catch (e) {
      _pekerjaanList.value = Result.error(e.toString());
    }
  }

  void _fetchPendidikanList() async {
    try {
      _pendidikanList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var pendidikanList =
          await pendidikanDatasource.getPendidikanList(userInfo!.negaraId);
      _pendidikanList.value = Result.success(pendidikanList);
    } catch (e) {
      _pendidikanList.value = Result.error(e.toString());
    }
  }

  void _fetchPenghasilanList() async {
    try {
      _penghasilanList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var penghasilanList =
          await penghasilanDatasource.getPenghasilanList(userInfo!.negaraId);
      _penghasilanList.value = Result.success(penghasilanList);
    } catch (e) {
      _penghasilanList.value = Result.error(e.toString());
    }
  }

  void onTapSaveProfesional() async {
    if (formGlobalKeyProfesional.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var userInfo = authDatasource.getUserInfo();
        await userDatasource.editWargaProfesional(
            tempWargaData['wargaid'],
            tempWargaData['pendidikanId'],
            tempWargaData['pekerjaanId'],
            tempWargaData['pekerjaanLain'],
            tempWargaData['namaPerusahaan'],
            tempWargaData['jenisUsaha'],
            tempWargaData['keahlian'],
            tempWargaData['penghasilanId'],
            tempWargaData['tanggungan'],
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

    namaUsahaTextEditingController.text = warga.namaPerusahaan;
    jenisUsahaTextEditingController.text = warga.jenisUsaha;
    keahlianTextEditingController.text = warga.keahlian;
    tanggunganTextEditingController.text = warga.jumlahTanggungan.toString();

    wargaData.value = {
      'wargaid': warga.wargaId,
      'pendidikanId': warga.pendidikanId,
      'pekerjaanId': warga.pekerjaanId,
      'pekerjaanLain': warga.pekerjaanLain,
      'namaPerusahaan': warga.namaPerusahaan,
      'jenisUsaha': warga.jenisUsaha,
      'keahlian': warga.keahlian,
      'penghasilanId': warga.penghasilanId,
      'tanggungan': warga.jumlahTanggungan,
    };

    tempWargaData.addAll(wargaData);

    _fetchPendidikanList();
    _fetchPekerjaanList();
    _fetchPenghasilanList();
  }
}
