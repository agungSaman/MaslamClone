import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/location_util.dart';
import '../../informasimasjid/view/detail/informasi_masjid_detail_page.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../../mainwrapper/view/main_wrapper_page.dart';
import '../data/datasources/my_masjid_datasource.dart';
import '../data/models/my_masjid_list.dart';

class MyMasjidController extends GetxController {
  static const _pageSize = 10;
  final AuthDatasource _authDatasource;
  final MyMasjidDatasource _myMasjidDatasource;

  MyMasjidController(this._authDatasource, this._myMasjidDatasource);

  final _currentUserLocationData = Rx<LocationData?>(null);
  LocationData? get currentUserLocationData => _currentUserLocationData.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final searchTextController = TextEditingController();
  final currentMasjidQuery = '%'.obs;

  final PagingController<int, MyMasjidList> pagingController =
      PagingController(firstPageKey: 0);

  void onRefresh() {
    pagingController.refresh();
  }

  void onTapBackButton() {
    Get.back();
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
      fetchMyMasjidList(0);

      _isLoading.value = false;
    } else {
      _isLoading.value = true;
    }
  }

  void fetchMyMasjidList(int page) {
    try {
      var userInfo = _authDatasource.getUserInfo();

      _myMasjidDatasource
          .readMyMasjidList(
        userInfo!.userId,
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

  void onTapMasjidDetail(String masjidId) async {
    var result = await Get.toNamed(InformasiMasjidDetailPage.routeName,
        arguments: masjidId);
    if (result != null) {
      pagingController.refresh();
    }
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

  void onTapBack(int position) async {
    Get.offAllNamed(
      MainWrapperPage.routeName,
      // arguments: MainWrapperPageParam(
      //   destination: HomePage.routeName,
      // )
    );
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
      fetchMyMasjidList(page);
    });
  }
}
