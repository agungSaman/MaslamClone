import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../commons/result.dart';
import '../../../utils/location_util.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../../shared/master/kegiatan/datasources/kegiatan_datasource.dart';
import '../../shared/master/kegiatan/models/kegiatan.dart';
import '../data/datasources/informasi_kegiatan_datasource.dart';
import '../data/models/informasi_kegiatan.dart';
import 'detail/informasi_kegiatan_detail_page.dart';

// import 'detail/informasi_kegiatan_detail_page.dart';

class InformasiKegiatanController extends GetxController {
  static const _pageSize = 10;
  final AuthDatasource _authDatasource;
  final InformasiKegiatanDatasource _informasiKegiatanDatasource;
  final KegiatanDatasource _kegiatanDatasource;

  InformasiKegiatanController(this._authDatasource,
      this._informasiKegiatanDatasource, this._kegiatanDatasource);

  final _currentUserLocationData = Rx<LocationData?>(null);
  LocationData? get currentUserLocationData => _currentUserLocationData.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _kategoriKegiatanList = Result.success(<Kegiatan>[]).obs;
  Result<List<Kegiatan>> get kategoriKegiatanList =>
      _kategoriKegiatanList.value;

  final searchTextController = TextEditingController();
  final currentKegiatanQuery = '%'.obs;
  final currentKategoriQuery = '%'.obs;
  final currentOptionQuery = 'Terdekat'.obs;

  final warnaTerdekat = const Color.fromRGBO(9, 56, 131, 1).obs;
  final warnaFavorit = Colors.white.obs;
  final warnaJamaah = Colors.white.obs;

  final textTerdekat = Colors.white.obs;
  final textFavorit = const Color.fromRGBO(67, 120, 255, 1).obs;
  final textJamaah = const Color.fromRGBO(67, 120, 255, 1).obs;

  final PagingController<int, InformasiKegiatan> pagingController =
      PagingController(firstPageKey: 0);

  void onTapKegiatanDetail(String kegiatanId) {
    Get.toNamed(InformasiKegiatanDetailPage.routeName, arguments: kegiatanId);
  }

  void onRefresh() {
    pagingController.refresh();
  }

  void onTapBackButton() {
    Get.back();
  }

  void _fetchKategoriKegiatanList() async {
    try {
      _kategoriKegiatanList.value = Result.loading();
      var masterKegiatanList = await _kegiatanDatasource
          .getKegiatanMaster('bfb966dd-9d78-4ae2-bba8-43688abbd272');

      currentKategoriQuery.value = masterKegiatanList.first.nama;

      _kategoriKegiatanList.value = Result.success(masterKegiatanList);
    } catch (e) {
      _kategoriKegiatanList.value = Result.error(e.toString());
    }
  }

  void onTapOption(int urutan) {
    if (urutan == 1) {
      warnaTerdekat.value = const Color.fromRGBO(9, 56, 131, 1);
      warnaFavorit.value = Colors.white;
      warnaJamaah.value = Colors.white;

      textTerdekat.value = Colors.white;
      textFavorit.value = const Color.fromRGBO(67, 120, 255, 1);
      textJamaah.value = const Color.fromRGBO(67, 120, 255, 1);

      currentOptionQuery.value = 'Terdekat';
      onRefresh();
    } else if (urutan == 2) {
      warnaTerdekat.value = Colors.white;
      warnaFavorit.value = const Color.fromRGBO(9, 56, 131, 1);
      warnaJamaah.value = Colors.white;

      textTerdekat.value = const Color.fromRGBO(67, 120, 255, 1);
      textFavorit.value = Colors.white;
      textJamaah.value = const Color.fromRGBO(67, 120, 255, 1);

      currentOptionQuery.value = 'Favorite';
      onRefresh();
    } else if (urutan == 3) {
      warnaTerdekat.value = Colors.white;
      warnaFavorit.value = Colors.white;
      warnaJamaah.value = const Color.fromRGBO(9, 56, 131, 1);

      textTerdekat.value = const Color.fromRGBO(67, 120, 255, 1);
      textFavorit.value = const Color.fromRGBO(67, 120, 255, 1);
      textJamaah.value = Colors.white;

      currentOptionQuery.value = 'Masjid Jamaah';
      onRefresh();
    }
  }

  void getPermission() async {
    if (await Permission.location.isGranted) {
      getCoordinate();
      // } else if (await Permission.location.isDenied) {
      //   SystemNavigator.pop();
    } else {
      Permission.location.request();
    }
  }

  void getCoordinate() async {
    _isLoading.value = true;
    _currentUserLocationData.value = await LocationUtil.getCurrentCoordinate();

    if (currentUserLocationData != null) {
      fetchInformasiKegiatanList(0);

      _isLoading.value = false;
    } else {
      _isLoading.value = true;
    }
  }

  void fetchInformasiKegiatanList(int page) async {
    try {
      if (currentOptionQuery.value == 'Terdekat') {
        _informasiKegiatanDatasource
            .getKegiatanByMasjidTerdekat(
          currentUserLocationData!.latitude!,
          currentUserLocationData!.longitude!,
          currentKategoriQuery.value,
          currentKegiatanQuery.value,
          page,
          _pageSize,
        )
            .then((value) {
          final isLastPage = value.length < _pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(value);
          } else {
            pagingController.appendPage(value, page + 1);
          }
        });
      } else if (currentOptionQuery.value == 'Favorite') {
        var isUserSignedIn = await _authDatasource.isUserSignedIn();

        if (isUserSignedIn) {
          var userInfo = _authDatasource.getUserInfo();

          _informasiKegiatanDatasource
              .getKegiatanByMasjidFavorit(
            userInfo!.userId,
            currentKategoriQuery.value,
            currentKegiatanQuery.value,
            page,
            _pageSize,
          )
              .then((value) {
            final isLastPage = value.length < _pageSize;
            if (isLastPage) {
              pagingController.appendLastPage(value);
            } else {
              pagingController.appendPage(value, page + 1);
            }
          });
        } else {
          apakahLogin();
        }
      }
      if (currentOptionQuery.value == 'Masjid Jamaah') {
        _informasiKegiatanDatasource
            .getKegiatanByMasjidJamaah(
          currentKategoriQuery.value,
          currentKegiatanQuery.value,
          page,
          _pageSize,
        )
            .then((value) {
          final isLastPage = value.length < _pageSize;
          if (isLastPage) {
            pagingController.appendLastPage(value);
          } else {
            pagingController.appendPage(value, page + 1);
          }
        });
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onChangeSearchTextField(String value) {
    currentKegiatanQuery.value = value;
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
    getCoordinate();

    _fetchKategoriKegiatanList();

    everAll([currentKegiatanQuery], (value) {});

    debounce(currentKegiatanQuery, (String value) {
      pagingController.refresh();
    }, time: const Duration(seconds: 1));

    pagingController.addPageRequestListener((page) {
      fetchInformasiKegiatanList(page);
    });
  }
}
