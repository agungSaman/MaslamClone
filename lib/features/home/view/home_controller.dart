import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

import '../../../commons/result.dart';
import '../../../utils/location_util.dart';
import '../../account/about/view/under_development_page.dart';
import '../../informasikegiatan/view/informasi_kegiatan_page.dart';
import '../../informasimasjid/data/models/masjid_list.dart';
import '../../informasimasjid/view/detail/informasi_masjid_detail_page.dart';
import '../../informasimasjid/view/informasi_masjid_page.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../../mainwrapper/view/main_wrapper_controller.dart';
import '../../shared/user/data/models/user.dart';
import '../data/datasources/administrative_tools_datasource.dart';
import '../data/datasources/home_tab_datasource.dart';
import '../data/models/banner_list.dart';
import '../data/models/home_type.dart';
import '../data/models/menu_feature_flag.dart';
import '../data/models/nearest_pray_time.dart';
import '../data/models/pray_time.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AdministrativeToolsDatasource _administrativeToolsDatasource;
  final HomeTabDatasource _homeTabDatasource;
  final AuthDatasource _authDatasource;
  final MainWrapperController _mainWrapperController;

  HomeController(this._administrativeToolsDatasource, this._homeTabDatasource,
      this._authDatasource, this._mainWrapperController);

  final _currentUserLocationData = Rx<loc.LocationData?>(null);
  loc.LocationData? get currentUserLocationData =>
      _currentUserLocationData.value;

  final _placemark = Rx<List<Placemark>?>(null);
  List<Placemark>? get placemark => _placemark.value;

  final _nearestPrayTime = Result.success(
          NearestPrayTime(waktuSholat: '', tanggalWaktuSholat: '', waktu: ''))
      .obs;
  Result<NearestPrayTime> get nearestPrayTime => _nearestPrayTime.value;

  final _prayTime = Result.success(PrayTime(
          tanggal: '',
          imsak: '',
          subuh: '',
          terbit: '',
          dzuhur: '',
          ashar: '',
          maghrib: '',
          isya: ''))
      .obs;
  Result<PrayTime> get prayTime => _prayTime.value;

  final _mosqueList = Result.success(<MasjidList>[]).obs;
  Result<List<MasjidList>> get mosqueList => _mosqueList.value;

  final _bannerList = Result.success(<BannerList>[]).obs;
  Result<List<BannerList>> get bannerList => _bannerList.value;

  late AnimationController animationController;

  final _countdownTimer = Rx<Timer?>(null);
  Timer? get countdownTimer => _countdownTimer.value;

  final _remainingTime = Rx<Duration>(Duration.zero);
  Duration get remainingTime => _remainingTime.value;

  String strDigits(int n) => n.toString().padLeft(2, '0');

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _activeIndex = 0.obs;
  int get activeIndex => _activeIndex.value;

  final _isUserSignIn = false.obs;
  bool get isUserSignIn => _isUserSignIn.value;

  void changeIndex(int index) {
    _activeIndex.value = index;
  }

  final tabList = HomeType.values.toList();

  final _menuFeatureFlag = Result.success(<MenuFeatureFlag>[]).obs;

  Result<List<MenuFeatureFlag>> get menuFeatureFlag => _menuFeatureFlag.value;

  String get username => userInfo?.email ?? '';

  late User? userInfo;

  final _hariIni = DateTime.now().obs;
  DateTime get hariIni => _hariIni.value;

  // final _warnaSholat = const Color(0xFFAEAEAE).obs;
  // Color get warnaSholat => _warnaSholat.value;

  late TabController tabController;

  void setCurrentTabPosition(HomeType tab) {
    tabController.index = tabList.indexOf(tab);
  }

  void getPermissionHome() async {
    if (await Permission.location.isGranted) {
      getCoordinateHome();
      // } else if (await Permission.location.isDenied) {
      //   SystemNavigator.pop();
    } else {
      Permission.location.request();
    }
  }

  void getCoordinateHome() async {
    _isLoading.value = true;
    _currentUserLocationData.value = await LocationUtil.getCurrentCoordinate();

    if (currentUserLocationData != null) {
      getAddress();
      fetchNearestPrayTime();
      fetchMosqueList();

      _isLoading.value = false;
    } else {
      _isLoading.value = true;
    }
  }

  void getPermissionSholat() async {
    if (await Permission.location.isGranted) {
      getCoordinateHome();
      // } else if (await Permission.location.isDenied) {
      //   SystemNavigator.pop();
    } else {
      Permission.location.request();
    }
  }

  void getCoordinateSholat() async {
    _isLoading.value = true;
    _currentUserLocationData.value = await LocationUtil.getCurrentCoordinate();

    if (currentUserLocationData != null) {
      // getAddress();
      // fetchNearestPrayTime();
      // fetchMosqueList();

      _isLoading.value = false;
    } else {
      _isLoading.value = true;
    }
  }

  void getAddress() async {
    if (currentUserLocationData != null) {
      _isLoading.value = true;
      _placemark.value = await placemarkFromCoordinates(
          currentUserLocationData!.latitude!,
          currentUserLocationData!.longitude!);
      _isLoading.value = false;
    }
  }

  void fetchNearestPrayTime() async {
    try {
      _nearestPrayTime.value = Result.loading();
      var waktuTerdekat = await _homeTabDatasource.getNearestPrayTime(
          currentUserLocationData!.latitude!,
          currentUserLocationData!.longitude!,
          DateTime.now());
      _nearestPrayTime.value = Result.success(waktuTerdekat);

      if (nearestPrayTime.status == Status.success) {
        startCountdownTimer(nearestPrayTime.data!.tanggalWaktuSholat);
        fetchPrayTime(hariIni);
      }
    } catch (e) {
      _nearestPrayTime.value = Result.error(e.toString());
    }
  }

  void fetchPrayTime(DateTime tanggal) async {
    try {
      _prayTime.value = Result.loading();
      var waktuSholat = await _homeTabDatasource.getPrayTime(
          currentUserLocationData!.latitude!,
          currentUserLocationData!.longitude!,
          tanggal);
      _prayTime.value = Result.success(waktuSholat);
    } catch (e) {
      _nearestPrayTime.value = Result.error(e.toString());
    }
  }

  void fetchBannerList() async {
    try {
      _bannerList.value = Result.loading();
      var bannerList = await _homeTabDatasource.getBannerList(null);
      _bannerList.value = Result.success(bannerList);
    } catch (e) {
      _bannerList.value = Result.error(e.toString());
    }
  }

  void fetchMosqueList() async {
    try {
      _mosqueList.value = Result.loading();
      var mosqueList = await _homeTabDatasource.getNearestMosque(
          currentUserLocationData!.latitude!,
          currentUserLocationData!.longitude!,
          0,
          3);
      _mosqueList.value = Result.success(mosqueList);
    } catch (e) {
      _mosqueList.value = Result.error(e.toString());
    }
  }

  void startCountdownTimer(String sholatTime) {
    DateTime parsedTime = DateTime.parse(sholatTime);
    DateTime now = DateTime.now();
    Duration difference = parsedTime.difference(now);

    // Initialize the countdown timer with the time difference
    _countdownTimer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime.value = difference - Duration(seconds: timer.tick);

      // Update the remaining time every second
      _remainingTime.value = difference - Duration(seconds: timer.tick);

      if (remainingTime.inSeconds <= 0) {
        countdownTimer?.cancel();
      }
    });
  }

  void onTapYesterday() async {
    _hariIni.value = hariIni.subtract(const Duration(days: 1));
    fetchPrayTime(hariIni);
  }

  void onTapTommorow() async {
    _hariIni.value = hariIni.add(const Duration(days: 1));
    fetchPrayTime(hariIni);
  }

  Color cekWarnaSholat(var waktu) {
    if (nearestPrayTime.data!.waktu == waktu) {
      return const Color.fromRGBO(68, 120, 255, 1.0);
    } else {
      return const Color.fromRGBO(174, 174, 174, 1);
    }
  }

  bool cekWaktuSama(var tanggal, var waktu) {
    String jadwal = '$tanggal $waktu';
    if (nearestPrayTime.data!.tanggalWaktuSholat == jadwal) {
      return true;
    } else {
      return false;
    }
  }

  void onTapMenu(String label) {
    switch (label) {
      case 'Informasi Masjid':
        Get.toNamed(InformasiMasjidPage.routeName);
        break;
      case 'Kegiatan Masjid':
        Get.toNamed(InformasiKegiatanPage.routeName);
        break;
      default:
        Get.toNamed(UnderDevelopmentPage.routeName);
        break;
    }
  }

  void onTapMasjidDetail(String masjidId) {
    Get.toNamed(InformasiMasjidDetailPage.routeName, arguments: masjidId);
  }

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
  void onInit() async {
    super.onInit();

    checkSignIn();
    _isLoading.value = true;
    _nearestPrayTime.value = Result.loading();
    _bannerList.value = Result.loading();
    _mosqueList.value = Result.loading();

    fetchBannerList();
    getPermissionHome();
    getPermissionSholat();

    tabController = TabController(
      length: tabList.length,
      vsync: this,
    );

    // if (Get.arguments != null) {
    //   var param = (Get.arguments as MainWrapperPageParam);
    //   if (param.param != null) {
    //     setCurrentTabPosition(param.param);
    //   }
    // }
    //fetchData();
  }

  void fetchData() {
    userInfo = _authDatasource.getUserInfo();
    _menuFeatureFlag.value = Result.loading();

    //_mainWrapperController.fetchNotificationCount();

    _administrativeToolsDatasource.getMenuFeatureFlag(userInfo!.userId).then(
        (value) => _menuFeatureFlag.value = Result.success(value),
        onError: (error) => Result.error(error.toString()));
  }

  bool isFeatureEnabled(String key) {
    var menuItem = _menuFeatureFlag.value.data!
        .firstWhereOrNull((item) => item.menuName == key);
    if (menuItem != null) {
      return menuItem.isEnabled;
    } else {
      return false;
    }
  }

  void onTapMasjidList() {
    Get.toNamed(InformasiMasjidPage.routeName);
  }

  // void onTapMasterData() {
  //   Get.toNamed(MasterDataPage.routeName);
  // }
}
