import 'package:get/get.dart';

// import 'package:image_picker/image_picker.dart';

import '../../../commons/result.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../about/view/about_page.dart';
import '../changepassword/view/change_password_page.dart';
import '../data/datasources/user_datasource.dart';
import '../data/models/warga.dart';
import '../logout/view/logout_page.dart';
import '../warga/view/warga_page.dart';

class AccountController extends GetxController {
  final AuthDatasource _authDatasource;
  final UserDatasource _userDatasource;

  AccountController(this._authDatasource, this._userDatasource);

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

  // final _picker = ImagePicker();
  // final _empPhoto = Rx<XFile?>(null);
  // XFile? get empPhoto => _empPhoto.value;

  //late User userData;

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

  void onTapSignOutButton() {
    Get.toNamed(LogoutPage.routeName);
  }

  void onTapChangePassword() async {
    var result = await Get.toNamed(ChangePasswordPage.routeName);
    if (result != null) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'Success',
          message: 'Your password has been reset successfully');
    }
  }

  void onTapEditWargaProfil() async {
    // var result =
    await Get.toNamed(WargaPage.routeName);
    // if (result != null) {
    //   Get.rawSnackbar(
    //       snackPosition: SnackPosition.TOP,
    //       title: 'Success',
    //       message: 'Your personal info successfully updated');
    // }
    fetchAkun();
  }

  // void onTapOpenCamera() async {
  //   final XFile? image = await _picker.pickImage(
  //       source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
  //   if (image != null) {
  //     _empPhoto.value = image;
  //     uploadUserPhoto();
  //     Get.back();
  //   }
  // }

  // void onTapOpenGallery() async {
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     _empPhoto.value = image;
  //     uploadUserPhoto();
  //     Get.back();
  //   }
  // }

  // void uploadUserPhoto() async {
  //   try {
  //     var userInfo = _authDatasource.getUserInfo();
  //     await _userDatasource.uploadPhotoAccount(
  //         userInfo!.empId, empPhoto);
  //     onInit();
  //     Get.back(result: true);
  //   } catch (error) {
  //     Get.rawSnackbar(
  //         snackPosition: SnackPosition.TOP,
  //         title: 'An error occurred',
  //         message: error.toString());
  //   }
  // }

  void onTapAbout() {
    Get.toNamed(AboutPage.routeName);
  }

  @override
  void onInit() {
    super.onInit();

    fetchAkun();
  }
}
