import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../commons/result.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../login/data/datasources/auth_datasource.dart';
import '../../../../shared/gender/data/datasources/gender_datasource.dart';
import '../../../../shared/gender/data/models/gender.dart';
import '../../../../shared/status_rumah/data/datasources/status_rumah_datasource.dart';
import '../../../../shared/status_rumah/data/models/status_rumah.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../data/models/warga.dart';

class EditProfileWargaController extends GetxController {
  final AuthDatasource authDatasource;
  final UserDatasource userDatasource;
  final GenderDatasource genderDatasource;
  final StatusRumahDatasource statusRumahDatasource;

  EditProfileWargaController(this.authDatasource, this.userDatasource,
      this.genderDatasource, this.statusRumahDatasource);

  final _genderList = Result.success(<Gender>[]).obs;
  final _statusRumahList = Result.success(<StatusRumah>[]).obs;

  Result<List<Gender>> get genderList => _genderList.value;
  Result<List<StatusRumah>> get statusRumahList => _statusRumahList.value;

  final wargaData = {}.obs;
  final tempWargaData = {}.obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final formGlobalKeyProfil = GlobalKey<FormState>();
  late Warga warga;
  late DateTime birthDate;

  void onChangeWargaIntField(String key, int value) {
    tempWargaData[key] = value;
  }

  void onChangeWargaStringField(String key, String value) {
    tempWargaData[key] = value;
    if (key == 'goldar') {
      _goldar.value = value;
    }
  }

  void onChangeBooleanField(String key, bool? value) {
    tempWargaData[key] = value;
  }

  final namaTextEditingController = TextEditingController();
  final birthdateTextEditingController =
      (DateTime.now().dayMonthYearDateFormat).obs;
  final birthplaceTextEditingController = TextEditingController();
  final alamatTextEditingController = TextEditingController();
  final tinggalSejakTextEditingController = TextEditingController();
  final goldarTextEditingController = TextEditingController();
  final daerahAsalTextEditingController = TextEditingController();
  final noKtpTextEditingController = TextEditingController();

  void onTapBackButton() {
    Get.back();
  }

  List<String> bloodTypes = [
    '-',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  final _goldar = '-'.obs;
  String get goldar => _goldar.value;

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  void onBirthDate(DateTime? pickedDate) {
    if (pickedDate != null) {
      tempWargaData['tglLahir'] = yearMonthDayDateFormatter.format(pickedDate);

      birthdateTextEditingController.value =
          dayMonthYearDateFormatter.format(pickedDate);
    }
  }

  void _fetchGenderList() async {
    try {
      _genderList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var genderList = await genderDatasource.getJKList(userInfo!.negaraId);
      _genderList.value = Result.success(genderList);
    } catch (e) {
      _genderList.value = Result.error(e.toString());
    }
  }

  void _fetchStatusRumahList() async {
    try {
      _statusRumahList.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var statusRumahList =
          await statusRumahDatasource.getStatusRumahList(userInfo!.negaraId);
      _statusRumahList.value = Result.success(statusRumahList);
    } catch (e) {
      _statusRumahList.value = Result.error(e.toString());
    }
  }

  void onTapSaveProfil() async {
    if (formGlobalKeyProfil.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var userInfo = authDatasource.getUserInfo();
        await userDatasource.editWargaProfil(
            tempWargaData['wargaid'],
            tempWargaData['nama'],
            tempWargaData['jkId'],
            tempWargaData['tempatLahir'],
            tempWargaData['tglLahir'],
            tempWargaData['alamat'],
            tempWargaData['statusRumahId'],
            tempWargaData['tinggalSejak'].toString(),
            tempWargaData['goldar'],
            tempWargaData['daerahAsal'],
            tempWargaData['noKtp'],
            userInfo!.userId);
        _isLoading.value = false;
        Get.back(result: true);
      } catch (error) {
        _isLoading.value = false;
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'An error occurred',
            message: error.toString());
      }
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    String birthDateInit;

    warga = Get.arguments;

    namaTextEditingController.text = warga.nama;
    birthplaceTextEditingController.text = warga.tempatLahir;
    alamatTextEditingController.text = warga.alamatRumah;
    tinggalSejakTextEditingController.text = warga.tahunDomisili.toString();
    goldarTextEditingController.text = warga.golonganDarah;
    daerahAsalTextEditingController.text = warga.daerahAsal;
    noKtpTextEditingController.text = warga.noKtp;

    /// set initial value
    _goldar.value = warga.golonganDarah;

    if (warga.tglLahir != '-') {
      birthDate = DateTime.parse(warga.tglLahir);
      birthDateInit = DateTime.parse(warga.tglLahir).yearMonthDayDateFormat;
      birthdateTextEditingController.value =
          DateTime.parse(warga.tglLahir).dayMonthYearDateFormat;
    } else {
      birthDate = DateTime.now();
      birthDateInit = DateTime.now().yearMonthDayDateFormat;
      birthdateTextEditingController.value =
          DateTime.now().dayMonthYearDateFormat;
    }

    wargaData.value = {
      'wargaid': warga.wargaId,
      'nama': warga.nama,
      'jkId': warga.jenisKelaminId,
      'tempatLahir': warga.tempatLahir,
      'tglLahir': birthDateInit,
      'alamat': warga.alamatRumah,
      'statusRumahId': warga.statusRumahId,
      'tinggalSejak': warga.tahunDomisili,
      'goldar': warga.golonganDarah,
      'daerahAsal': warga.daerahAsal,
      'noKtp': warga.noKtp,
    };

    tempWargaData.addAll(wargaData);

    _fetchGenderList();
    _fetchStatusRumahList();
  }
}
