import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/location_util.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../data/datasources/informasi_masjid_datasource.dart';
import '../data/models/masjid_list.dart';
import 'detail/informasi_masjid_detail_page.dart';

class InformasiMasjidController extends GetxController {
  static const _pageSize = 10;
  final AuthDatasource _authDatasource;
  final InformasiMasjidDatasource _informasiMasjidDatasource;

  InformasiMasjidController(
      this._authDatasource, this._informasiMasjidDatasource);

  final _currentUserLocationData = Rx<LocationData?>(null);
  LocationData? get currentUserLocationData => _currentUserLocationData.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final searchTextController = TextEditingController();
  final currentMasjidQuery = '%'.obs;

  final PagingController<int, MasjidList> pagingController =
      PagingController(firstPageKey: 0);

  void onRefresh() {
    pagingController.refresh();
  }

  void onTapBackButton() {
    Get.back();
  }

  void onTapMasjidDetail(String masjidId) {
    Get.toNamed(InformasiMasjidDetailPage.routeName, arguments: masjidId);
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
      fetchInformasiMasjidList(0);

      _isLoading.value = false;
    } else {
      _isLoading.value = true;
    }
  }

  void fetchInformasiMasjidList(int page) {
    try {
      _informasiMasjidDatasource
          .getMasjidList(
        currentUserLocationData!.latitude!,
        currentUserLocationData!.longitude!,
        currentMasjidQuery.value,
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
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onChangeSearchTextField(String value) {
    currentMasjidQuery.value = value;
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

    everAll([currentMasjidQuery], (value) {});

    debounce(currentMasjidQuery, (String value) {
      pagingController.refresh();
    }, time: const Duration(seconds: 1));

    pagingController.addPageRequestListener((page) {
      fetchInformasiMasjidList(page);
    });
  }
}
