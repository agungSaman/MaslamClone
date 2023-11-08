import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../commons/result.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/user_datasource.dart';
import '../../data/models/warga.dart';

class EditAlamatTeleponController extends GetxController {
  final AuthDatasource authDatasource;
  final UserDatasource userDatasource;

  EditAlamatTeleponController(this.authDatasource, this.userDatasource);

  final _dataWarga = Result.success(Warga(
    wargaId: '',
    userId: '',
    memberSince: '',
    createdDate: '',
    nama: '',
    jenisKelaminId: '',
    jenisKelaminNama: '',
    tempatLahir: '',
    tglLahir: '',
    daerahAsal: '',
    noKtp: '',
    alamatRumah: '',
    // longitude: '',
    // latitude: '',
    statusRumahId: '',
    statusRumahNama: '',
    tahunDomisili: 1990,
    golonganDarah: '',
    pendidikanId: '',
    pendidikanNama: '',
    pekerjaanId: '',
    pekerjaanNama: '',
    pekerjaanLain: '',
    namaPerusahaan: '',
    jenisUsaha: '',
    keahlian: '',
    statusBacaAlquranId: '',
    statusBacaAlquranNama: '',
    isHaji: false,
    noHp: '',
    email: '',
    penghasilanId: '',
    penghasilanNama: '',
    jumlahTanggungan: 0,
    isMeninggal: false,
    tglMeninggal: '',
    isFoto: false,
    fotoExt: '',
    namaFile: '',
  )).obs;

  Result<Warga> get dataWarga => _dataWarga.value;

  final _noHp = ''.obs;
  String get noHp => _noHp.value;

  final _alamat = ''.obs;
  String get alamat => _alamat.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late String masjidId;

  final formGlobalKeyAlamatTelepon = GlobalKey<FormState>();

  void onChangeStringField(String value, String key) {
    if (key == 'noHp') {
      _noHp.value = value;
    } else {
      _alamat.value = value;
    }
  }

  final noHpTextEditingController = TextEditingController();
  final alamatTextEditingController = TextEditingController();

  void onTapBackButton() {
    Get.back(result: false);
  }

  bool isFormFieldNotNullAndNotEmpty(String? value) =>
      value != null && value.isNotEmpty;

  String? isTextFormValid(String? value) {
    if (isFormFieldNotNullAndNotEmpty(value)) {
      return null;
    } else {
      return 'field tidak boleh kosong';
    }
  }

  void fetchAkun() async {
    try {
      _dataWarga.value = Result.loading();
      var userInfo = authDatasource.getUserInfo();
      var warga = await userDatasource.readWargaByUserId(userInfo!.userId);
      _dataWarga.value = Result.success(warga);

      noHpTextEditingController.text = warga.noHp;
      alamatTextEditingController.text = warga.alamatRumah;
    } catch (e) {
      _dataWarga.value = Result.error(e.toString());
    }
  }

  void onTapSave() async {
    if (formGlobalKeyAlamatTelepon.currentState!.validate()) {
      try {
        _isLoading.value = true;
        var userInfo = authDatasource.getUserInfo();
        await userDatasource.editWargaAlamatTelepon(
          userInfo!.userId,
          userInfo.nama,
          noHpTextEditingController.text,
          alamatTextEditingController.text,
        );

        await userDatasource.requestJamaahMasjid(userInfo.userId, masjidId);

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

    masjidId = Get.arguments;

    fetchAkun();
  }
}
