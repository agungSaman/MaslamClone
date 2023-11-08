import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commons/result.dart';
import '../../../account/about/view/under_development_page.dart';
import '../../../account/edit/alamat_telepon/edit_alamat_telepon_page.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../../login/view/login_page.dart';
import '../../../mainwrapper/view/main_wrapper_controller.dart';
import '../../../mymasjid/view/my_masjid_page.dart';
import '../../data/datasources/informasi_masjid_datasource.dart';
import '../../data/models/masjid_banner_list.dart';
import '../../data/models/masjid_description.dart';
import '../../data/models/masjid_detail.dart';
import '../../data/models/masjid_fasilitas.dart';
import '../../data/models/masjid_kegiatan.dart';
import '../../data/models/masjid_kontak.dart';
import '../../data/models/masjid_pengurus.dart';

class InformasiMasjidDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthDatasource _authDatasource;
  final InformasiMasjidDatasource _informasiMasjidDatasource;

  InformasiMasjidDetailController(
      this._authDatasource, this._informasiMasjidDatasource);

  late String masjidId;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _masjidDetail = Result.success(MasjidDetail(
    masjidId: '',
    createdBy: '',
    createdName: '',
    createdDate: '',
    updatedBy: '',
    updatedName: '',
    lastUpdated: '',
    rowversion: '',
    negaraId: '',
    negaraNama: '',
    nama: '',
    alamat: '',
    propinsiId: '',
    propinsiNama: '',
    kotaId: '',
    kotaNama: '',
    kecamatanId: '',
    kecamatanNama: '',
    kelurahanId: '',
    kelurahanNama: '',
    distance: 0.00,
    latitude: 0.00,
    longitude: 0.00,
    noTelp: '',
    email: '',
    tahunBerdiri: 0,
    luasTanah: 0.00,
    luasBangunan: 0.00,
    dayaTampung: 0,
    profile: '',
    profileEn: '',
    fotoProfile: '',
    isMultiBahasa: false,
    isStrukturJabatan: false,
    isApprove: false,
    isAktif: false,
    isLaporanKeuanganPublik: false,
    timezoneId: '',
    namaTimezone: '',
    konfirmasiWaDonasi: '',
    jarak: '',
    waktuTempuh: '',
    isJamaah: false,
    isBookmark: false,
    isLike: false,
  )).obs;
  Result<MasjidDetail> get masjidDetail => _masjidDetail.value;

  final _masjidDescription = Result.success(MasjidDescription(
    masjidId: '',
    profile: '',
    noTelp: '',
    email: '',
    namaKelurahan: '',
    namaKota: '',
  )).obs;
  Result<MasjidDescription> get masjidDescription => _masjidDescription.value;

  final _masjidBannerList = Result.success(<MasjidBannerList>[]).obs;
  Result<List<MasjidBannerList>> get masjidBannerList =>
      _masjidBannerList.value;

  final _masjidFasilitasList = Result.success(<MasjidFasilitas>[]).obs;
  Result<List<MasjidFasilitas>> get masjidFasilitasList =>
      _masjidFasilitasList.value;

  final _masjidKegiatanList = Result.success(<MasjidKegiatan>[]).obs;
  Result<List<MasjidKegiatan>> get masjidKegiatanList =>
      _masjidKegiatanList.value;

  final _masjidPengurusList = Result.success(<MasjidPengurus>[]).obs;
  Result<List<MasjidPengurus>> get masjidPengurusList =>
      _masjidPengurusList.value;

  final _masjidKontakList = Result.success(<MasjidKontak>[]).obs;
  Result<List<MasjidKontak>> get masjidKontakList => _masjidKontakList.value;

  final _activeIndex = 0.obs;
  int get activeIndex => _activeIndex.value;

  final _isExpandedDesc = false.obs;
  bool get isExpandedDesc => _isExpandedDesc.value;

  final _isExpandedDKM = false.obs;
  bool get isExpandedDKM => _isExpandedDKM.value;

  final _isExpandedPeta = false.obs;
  bool get isExpandedPeta => _isExpandedPeta.value;

  final _isJamaah = false.obs;
  bool get isJamaah => _isJamaah.value;

  final _isBookmark = false.obs;
  bool get isBookmark => _isBookmark.value;

  final _isLike = false.obs;
  bool get isLike => _isLike.value;

  final optionVisible = false.obs;
  bool get optionVisibleValue => optionVisible.value;

  // void onScroll(double currentOffset) => titleOpacity.value =
  //     currentOffset == Get.mediaQuery.padding.top + kToolbarHeight ? 1.0 : 0.0;

  late TabController tabInfoMasjidController;

  void onTapBackButton() {
    Get.back(result: true);
  }

  void changeIndex(int index) {
    _activeIndex.value = index;
  }

  void fetchMasjidDetail() async {
    try {
      var isUserSignedIn = await _authDatasource.isUserSignedIn();

      if (isUserSignedIn) {
        _masjidDetail.value = Result.loading();
        var userInfo = _authDatasource.getUserInfo();
        var masdet = await _informasiMasjidDatasource.getUserMasjidDetail(
            masjidId, userInfo!.userId);
        _masjidDetail.value = Result.success(masdet);
        _isJamaah.value = masjidDetail.data!.isJamaah;
        _isBookmark.value = masjidDetail.data!.isBookmark;
        _isLike.value = masjidDetail.data!.isLike;
      } else {
        _masjidDetail.value = Result.loading();
        var masdet = await _informasiMasjidDatasource.getMasjidDetail(masjidId);
        _masjidDetail.value = Result.success(masdet);
      }
    } catch (e) {
      _masjidDetail.value = Result.error(e.toString());
    }
  }

  void apakahLogin() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Login dibutuhkan',
          style: GoogleFonts.sourceSansPro(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color.fromRGBO(7, 56, 130, 1.0)),
        ),
        content: Text(
          'Untuk menggunakan fitur ini, anda harus login terlebih dahulu',
          style: GoogleFonts.sourceSansPro(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'Batal',
              style: GoogleFonts.sourceSansPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(LoginPage.routeName);
            },
            child: Text(
              'Ok',
              style: GoogleFonts.sourceSansPro(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapSelectedMenu(String pilihan) async {
    switch (pilihan) {
      case 'addbookmark':
        try {
          var isUserSignedIn = await _authDatasource.isUserSignedIn();
          if (isUserSignedIn) {
            _isLoading.value = true;
            var userInfo = _authDatasource.getUserInfo();

            await _informasiMasjidDatasource.createMasjidFavorit(
                userInfo!.userId,
                userInfo.nama,
                masjidDetail.data!.masjidId,
                masjidDetail.data!.nama);

            _isBookmark.value = true;

            _isLoading.value = false;
            Get.rawSnackbar(
                snackPosition: SnackPosition.TOP,
                title: 'Bookmark Berhasil',
                message: '${masjidDetail.data!.nama} sudah dibookmark');
          } else {
            apakahLogin();
          }
        } catch (error) {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              title: 'An error occurred',
              message: 'Bermasalah saat Bookmark Masjid');
        }

        break;
      case 'rembookmark':
        try {
          var userInfo = _authDatasource.getUserInfo();

          _isLoading.value = true;
          await _informasiMasjidDatasource.deleteMasjidFavorit(
              userInfo!.userId,
              userInfo.nama,
              masjidDetail.data!.masjidId,
              masjidDetail.data!.nama);

          _isBookmark.value = false;

          _isLoading.value = false;
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              title: 'Remove Bookmark Berhasil',
              message: '${masjidDetail.data!.nama} tidak lagi dibookmark');
        } catch (error) {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              title: 'An error occurred',
              message: 'Bermasalah saat Remove Bookmark Masjid');
        }
        break;
      case 'reqjamaah':
        try {
          _isLoading.value = true;
          var isUserSignedIn = await _authDatasource.isUserSignedIn();

          if (isUserSignedIn) {
            var userInfo = _authDatasource.getUserInfo();

            var detailUser =
                await _authDatasource.getDataWarga(userInfo!.userId);

            _isLoading.value = false;
            if (detailUser!.alamatRumah == '' || detailUser.noHp == '') {
              Get.dialog(
                AlertDialog(
                  title: Text(
                    'Alamat atau No HP anda belum terisi',
                    style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(7, 56, 130, 1.0),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Text(
                    'Apakah anda akan melengkapi data?',
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        lengkapiData();
                      },
                      child: Text(
                        'Ok',
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              await _informasiMasjidDatasource.requestJamaahMasjid(
                  userInfo.userId, masjidDetail.data!.masjidId);

              _isJamaah.value = true;

              _isLoading.value = false;

              if (Get.previousRoute.toString() == '/main-wrapper') {
                Get.back(result: true);
              }

              Get.rawSnackbar(
                  snackPosition: SnackPosition.TOP,
                  title: 'Pengajuan Berhasil',
                  message:
                      'Pengajuan sebagai Jamaah ${masjidDetail.data!.nama}');

              // if (!(Get.rawRoute!.isFirst)) {
              //   /// Assuming the previous page is my masjid page
              //   Get.back(result: true);
              // } else {
              //   Get.offAllNamed(MainWrapperPage.routeName,
              //       arguments: MainWrapperPageParam(
              //           destination: MyMasjidPage.routeName));
              // }
            }
          } else {
            apakahLogin();
          }
        } catch (error) {
          Get.rawSnackbar(
              snackPosition: SnackPosition.TOP,
              title: 'An error occurred',
              message: 'Bermasalah saat Pengajuan sebagai Jamaah Masjid');
        }
        break;
      case 'bagikan':
        break;
    }
  }

  void lengkapiData() async {
    var result =
        await Get.toNamed(EditAlamatTeleponPage.routeName, arguments: masjidId);
    if (result == true) {
      _isJamaah.value = true;
      Get.rawSnackbar(
          snackPosition: SnackPosition.TOP,
          title: 'Pengajuan Berhasil',
          message: 'Pengajuan sebagai Jamaah akan direview oleh DKM');
      Get.offAllNamed(MyMasjidPage.routeName,
          id: 1,
          arguments: MainWrapperPageParam(
            destination: MyMasjidPage.routeName,
          ));
    }
  }

  void onTapLike() async {
    if (isLike == true) {
      try {
        var userInfo = _authDatasource.getUserInfo();

        await _informasiMasjidDatasource.deleteMasjidLike(
            userInfo!.userId,
            userInfo.nama,
            masjidDetail.data!.masjidId,
            masjidDetail.data!.nama);

        _isLike.value = false;
      } catch (error) {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'An error occurred',
            message: 'Bermasalah saat unlike Masjid');
      }
    } else {
      try {
        var isUserSignedIn = await _authDatasource.isUserSignedIn();

        if (isUserSignedIn) {
          var userInfo = _authDatasource.getUserInfo();

          await _informasiMasjidDatasource.createMasjidLike(
              userInfo!.userId,
              userInfo.nama,
              masjidDetail.data!.masjidId,
              masjidDetail.data!.nama);

          _isLike.value = true;
        } else {
          apakahLogin();
        }
      } catch (error) {
        Get.rawSnackbar(
            snackPosition: SnackPosition.TOP,
            title: 'An error occurred',
            message: 'Bermasalah saat like Masjid');
      }
    }
  }

  void fetchBannerList() async {
    try {
      _masjidBannerList.value = Result.loading();
      var bannerList =
          await _informasiMasjidDatasource.getMasjidBannerList(masjidId);
      _masjidBannerList.value = Result.success(bannerList);
    } catch (e) {
      _masjidBannerList.value = Result.error(e.toString());
    }
  }

  void fetchMasjidDescription() async {
    try {
      _masjidDescription.value = Result.loading();
      var masdesc =
          await _informasiMasjidDatasource.getMasjidDescription(masjidId);
      _masjidDescription.value = Result.success(masdesc);
    } catch (e) {
      _masjidDescription.value = Result.error(e.toString());
    }
  }

  void fetchMasjidFasilitas() async {
    try {
      _masjidFasilitasList.value = Result.loading();
      var fasilitasList =
          await _informasiMasjidDatasource.getMasjidFasilitas(masjidId);
      _masjidFasilitasList.value = Result.success(fasilitasList);
    } catch (e) {
      _masjidFasilitasList.value = Result.error(e.toString());
    }
  }

  void fetchMasjidKegiatan() async {
    try {
      _masjidKegiatanList.value = Result.loading();
      var kegiatanList =
          await _informasiMasjidDatasource.getMasjidKegiatan(masjidId);
      _masjidKegiatanList.value = Result.success(kegiatanList);
    } catch (e) {
      _masjidKegiatanList.value = Result.error(e.toString());
    }
  }

  void fetchMasjidPengurus() async {
    try {
      _masjidPengurusList.value = Result.loading();
      var pengurusList =
          await _informasiMasjidDatasource.getMasjidPengurus(masjidId);
      _masjidPengurusList.value = Result.success(pengurusList);
    } catch (e) {
      _masjidPengurusList.value = Result.error(e.toString());
    }
  }

  void fetchMasjidKontak() async {
    try {
      _masjidKontakList.value = Result.loading();
      var kontakList =
          await _informasiMasjidDatasource.getMasjidKontak(masjidId);
      _masjidKontakList.value = Result.success(kontakList);
    } catch (e) {
      _masjidKontakList.value = Result.error(e.toString());
    }
  }

  void onTapMenu(String label) {
    // switch (label) {
    //   case 'Informasi Masjid':
    //     Get.toNamed(InformasiMasjidPage.routeName);
    //     break;
    //   default:
    //     Get.toNamed(UnderDevelopmentPage.routeName);
    //     break;
    // }
    Get.toNamed(UnderDevelopmentPage.routeName);
  }

  void onTapCollapseWidget(int urutan) {
    if (urutan == 1) {
      _isExpandedDesc.value = !isExpandedDesc;
    } else if (urutan == 2) {
      _isExpandedDKM.value = !isExpandedDKM;
    } else if (urutan == 3) {
      _isExpandedPeta.value = !isExpandedPeta;
    }
  }

  void fetchData() async {
    fetchMasjidDetail();
    fetchBannerList();
    fetchMasjidDescription();
    fetchMasjidFasilitas();
    fetchMasjidKegiatan();
    fetchMasjidPengurus();
    fetchMasjidKontak();
  }

  final _isUserSignIn = false.obs;
  bool get isUserSignIn => _isUserSignIn.value;

  void checkSignIn() async {
    var isUserSignedIn = await _authDatasource.isUserSignedIn();

    if (isUserSignedIn) {
      _isUserSignIn.value = true;
    } else {
      _isUserSignIn.value = false;
    }
  }

  void toLoginPage() {
    Get.toNamed(LoginPage.routeName);
  }

  @override
  void onInit() {
    super.onInit();
    checkSignIn();
    tabInfoMasjidController = TabController(vsync: this, length: 3);
    masjidId = Get.arguments;

    fetchData();
  }
}
