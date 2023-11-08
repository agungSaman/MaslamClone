import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../commons/result.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../data/datasources/user_datasource.dart';
import '../../data/models/warga.dart';
import '../edit/profesional/edit_profesional_warga_page.dart';
import '../edit/profile/edit_profile_warga_page.dart';
import '../edit/status/edit_status_warga_page.dart';

class WargaController extends GetxController {
  final AuthDatasource _authDatasource;
  final UserDatasource _userDatasource;

  WargaController(
    this._authDatasource,
    this._userDatasource,
  );

  final _picker = ImagePicker();
  final _wargaPhoto = Rx<XFile?>(null);
  XFile? get wargaPhoto => _wargaPhoto.value;

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

  void fetchAkun() async {
    try {
      _dataWarga.value = Result.loading();
      var userInfo = _authDatasource.getUserInfo();
      var warga = await _userDatasource.readWargaByUserId(userInfo!.userId);
      _dataWarga.value = Result.success(warga);
    } catch (e) {
      _dataWarga.value = Result.error(e.toString());
    }
  }

  void onTapBackButton() {
    Get.back(result: true);
  }

  void onTapEditProfil() async {
    var result = await Get.toNamed(EditProfileWargaPage.routeName,
        arguments: dataWarga.data);
    if (result != null) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'Save Successfull',
          message: 'Data Profil Warga berhasil disimpan');
      fetchAkun();
    }
  }

  void onTapEditProfesional() async {
    var result = await Get.toNamed(EditProfesionalWargaPage.routeName,
        arguments: dataWarga.data);
    if (result != null) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'Save Successfull',
          message: 'Data Profesional Warga berhasil disimpan');
      fetchAkun();
    }
  }

  void onTapEditStatus() async {
    var result = await Get.toNamed(EditStatusWargaPage.routeName,
        arguments: dataWarga.data);
    if (result != null) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'Save Successfull',
          message: 'Data Status berhasil disimpan');
      fetchAkun();
    }
  }

  void uploadEmployeePhoto() async {
    try {
      var userInfo = _authDatasource.getUserInfo();
      await _userDatasource.uploadPhotoAccount(
          userInfo!.userId, userInfo.nama, wargaPhoto);
      onInit();
      Get.back(result: true);
    } catch (error) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'An error occurred',
          message: error.toString());
    }
  }

  void onTapOpenCamera() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (image != null) {
      _wargaPhoto.value = image;
      uploadEmployeePhoto();
      Get.back();
    }
  }

  void onTapOpenGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _wargaPhoto.value = image;
      uploadEmployeePhoto();
      Get.back();
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchAkun();
  }
}
