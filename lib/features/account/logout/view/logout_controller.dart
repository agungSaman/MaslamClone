import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../main_binding.dart';
import '../../../login/data/datasources/auth_datasource.dart';
import '../../../splash/view/splash_page.dart';

class LogoutController extends GetxController {
  final AuthDatasource _authDatasource;

  LogoutController(this._authDatasource);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  void onTapYesButton() async {
    _authDatasource.clearUserInfo();
    _googleSignIn.disconnect();
    Get.deleteAll(force: true);
    await MainBinding().dependencies();
    Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        message: 'Anda telah Logout dari Maslam');

    Get.offAllNamed(SplashPage.routeName);
    // Get.offAllNamed(MainWrapperPage.routeName,
    //     arguments: MainWrapperPageParam(
    //       destination: HomePage.routeName,
    //     )
    // );
  }

  void onTapNoButton() {
    Get.back();
  }
}
