import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../commons/no_transition.dart';
import '../../../utils/navigator_util.dart';
import '../../account/about/view/under_development_page.dart';
import '../../account/view/account_binding.dart';
import '../../account/view/account_page.dart';
import '../../home/view/home_binding.dart';
import '../../home/view/home_page.dart';
import '../../login/data/datasources/auth_datasource.dart';
import '../../login/view/login_page.dart';
import '../../mymasjid/view/my_masjid_binding.dart';
import '../../mymasjid/view/my_masjid_page.dart';
import '../../shared/user/data/models/user.dart';
import 'main_wrapper_binding.dart';
import 'main_wrapper_page.dart';

class MainWrapperController extends GetxController {
  final AuthDatasource _authDatasource;

  MainWrapperController(this._authDatasource);

  final _notificationBadgeCounter = 0.obs;
  // final _currentIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  final _curentPage = ''.obs;

  late User userData;

  // int get currentIndex => _currentIndex.value;
  // String get currentPage => _curentPage.value;

  int get notificationBadgeCounter => _notificationBadgeCounter.value;

  List<String> get tabRoute => [
        HomePage.routeName,
        UnderDevelopmentPage.routeName,
        MyMasjidPage.routeName,
        UnderDevelopmentPage.routeName,
        AccountPage.routeName
      ];

  final List<Page<dynamic>> pages = [
    const MaterialPage(child: HomePage()),
    const MaterialPage(child: UnderDevelopmentPage()),
    const MaterialPage(child: MyMasjidPage()),
    const MaterialPage(child: UnderDevelopmentPage()),
    const MaterialPage(child: AccountPage()),
  ];

  // @override
  // void onInit() async {
  //   super.onInit();
  //   //fetchNotificationCount();
  // }

  void showMessage(String title, String message) {
    Get.rawSnackbar(
        snackPosition: SnackPosition.TOP, title: title, message: message);
  }

  // void checkSignIn() async {
  //   var isUserSignedIn = await _authDatasource.isUserSignedIn();

  //   if (isUserSignedIn) {
  //     userData = _authDatasource.getUserInfo()!;

  //     // fetchUserInformationHeader();
  //   } else {
  //     _goToLoginPage();
  //   }
  // }

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

  @override
  void onReady() {
    super.onReady();
    var param = (Get.arguments as MainWrapperPageParam?);
    if (param != null) {
      if (param.perbaharui == true) {}
      if (param.message != null) {
        showMessage(param.title!, param.destination!);
      }
      if (param.destination != null) {
        onTapBottomSheetItem(
            tabRoute.indexWhere((item) => item == param.destination));
      }
    }
  }

  void onTapBottomSheetItem(int position, {dynamic param}) async {
    if ((position == 2) || (position == 4)) {
      var isUserSignedIn = await _authDatasource.isUserSignedIn();

      if (isUserSignedIn) {
        currentIndex.value = position;
        _curentPage.value = tabRoute[position];
        Navpage.mainListNav.currentState!.pushNamed(_curentPage.value);
        pages[position];
        // Get.offAllNamed(MainWrapperPage.routeName);
        // Get.offAllNamed(tabRoute[position]);
        // Get.offAllNamed(MainWrapperPage.routeName,
        //     arguments: MainWrapperPageParam(
        //         destination: tabRoute[position]
        //     )
        // );
      } else {
        apakahLogin();
      }
    } else {
      currentIndex.value = position;
      _curentPage.value = tabRoute[position];
      Navpage.mainListNav.currentState!.pushNamed(_curentPage.value);
      pages[position];
      // Get.offAllNamed(MainWrapperPage.routeName);
      // Get.offAllNamed(tabRoute[position]);
      // Get.offAllNamed(MainWrapperPage.routeName,
      //     arguments: MainWrapperPageParam(
      //         destination: tabRoute[position]
      //     )
      // );
    }
  }

  // void fetchNotificationCount() async {
  //   var userInfo = _authDatasource.getUserInfo();
  // }

  Route? onGenerateRoute(RouteSettings settings, {Function(GetPageRoute)? feedBack}) {
    GetPageRoute? getPageRoute;

    switch (settings.name) {
      case HomePage.routeName:
        getPageRoute = GetPageRoute(
            settings: settings,
            page: () => const HomePage(),
            binding: HomeBinding(),
            popGesture: false,
            customTransition: NoTransition());
        break;
      case MyMasjidPage.routeName:
        getPageRoute = GetPageRoute(
            maintainState: false,
            settings: settings,
            page: () => const MyMasjidPage(),
            binding: MyMasjidBinding(),
            popGesture: false,
            customTransition: NoTransition());
        break;
      case AccountPage.routeName:
        getPageRoute = GetPageRoute(
            maintainState: false,
            settings: settings,
            page: () => const AccountPage(),
            binding: AccountBinding(),
            popGesture: false,
            customTransition: NoTransition());
        break;
      case UnderDevelopmentPage.routeName:
        getPageRoute = GetPageRoute(
            settings: settings,
            page: () => const UnderDevelopmentPage(),
            //binding: HomeBinding(),
            popGesture: false,
            customTransition: NoTransition());
        break;
      default:
        // return null;
        getPageRoute = GetPageRoute(
            settings: settings,
            page: () => const HomePage(),
            binding: HomeBinding(),
            popGesture: false,
            customTransition: NoTransition());
        break;
    }

    feedBack!(getPageRoute);
  }
}

class MainWrapperPageParam {
  final String? destination;
  final String? title;
  final String? message;
  final bool? perbaharui;

  MainWrapperPageParam(
      {this.destination, this.title, this.message, this.perbaharui});
}
