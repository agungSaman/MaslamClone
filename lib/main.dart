import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'features/account/about/view/about_page.dart';
import 'features/account/about/view/under_development_page.dart';
import 'features/account/changepassword/view/change_password_binding.dart';
import 'features/account/changepassword/view/change_password_page.dart';
import 'features/account/edit/alamat_telepon/edit_alamat_telepon_binding.dart';
import 'features/account/edit/alamat_telepon/edit_alamat_telepon_page.dart';
import 'features/account/logout/view/logout_binding.dart';
import 'features/account/logout/view/logout_page.dart';
import 'features/account/resetpassword/view/reset_password_binding.dart';
import 'features/account/resetpassword/view/reset_password_page.dart';
import 'features/account/view/account_binding.dart';
import 'features/account/view/account_page.dart';
import 'features/account/warga/edit/profesional/edit_profesional_warga_binding.dart';
import 'features/account/warga/edit/profesional/edit_profesional_warga_page.dart';
import 'features/account/warga/edit/profile/edit_profile_warga_binding.dart';
import 'features/account/warga/edit/profile/edit_profile_warga_page.dart';
import 'features/account/warga/edit/status/edit_status_warga_binding.dart';
import 'features/account/warga/edit/status/edit_status_warga_page.dart';
import 'features/account/warga/view/warga_binding.dart';
import 'features/account/warga/view/warga_page.dart';
import 'features/camera/view/camera_binding.dart';
import 'features/camera/view/camera_page.dart';
import 'features/home/view/home_binding.dart';
import 'features/home/view/home_page.dart';
import 'features/informasikegiatan/view/detail/informasi_kegiatan_detail_binding.dart';
import 'features/informasikegiatan/view/detail/informasi_kegiatan_detail_page.dart';
import 'features/informasikegiatan/view/informasi_kegiatan_binding.dart';
import 'features/informasikegiatan/view/informasi_kegiatan_page.dart';
import 'features/informasimasjid/view/detail/informasi_masjid_detail_binding.dart';
import 'features/informasimasjid/view/detail/informasi_masjid_detail_page.dart';
import 'features/informasimasjid/view/informasi_masjid_binding.dart';
import 'features/informasimasjid/view/informasi_masjid_page.dart';
import 'features/login/view/login_binding.dart';
import 'features/login/view/login_page.dart';
import 'features/login/view/otp/otp_gmail_binding.dart';
import 'features/login/view/otp/otp_gmail_page.dart';
import 'features/login/view/signup/signup_binding.dart';
import 'features/login/view/signup/signup_page.dart';
import 'features/mainwrapper/view/main_wrapper_binding.dart';
import 'features/mainwrapper/view/main_wrapper_page.dart';
import 'features/mymasjid/view/my_masjid_binding.dart';
import 'features/mymasjid/view/my_masjid_page.dart';
import 'features/passwordauth/view/password_auth_binding.dart';
import 'features/passwordauth/view/password_auth_page.dart';
import 'features/photopreview/view/photo_preview_binding.dart';
import 'features/photopreview/view/photo_preview_page.dart';
import 'features/splash/view/splash_binding.dart';
import 'features/splash/view/splash_page.dart';
import 'firebase_options.dart';
import 'main_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentFirebaseOptions,
  );
  await openPrivateDb();
  await mainBindingApp();
}

Future<void> mainBindingApp() async {
  var mainBinding = await MainBinding().dependencies();
  if (mainBinding) {
    initOnTokenRefresh();
    FirebaseMessaging.onMessage.listen((message) => debugPrint('ONMESSAGE'));
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('ONMESSAGEOPENEDAPP');
      // Get.off(() => ApprovalPage(),
      //     binding: ApprovalBinding(ApprovalType.outstanding),
      //     arguments: ApprovalPageParam(
      //         type: message.data['tran_status'] == 'W'
      //             ? ApprovalType.outstanding
      //             : ApprovalType.history,
      //         approvalType: message.data['tran_type'],
      //         oid: message.data['oid']));
    });

    //// dikomentarin dulu biar keliatan errornya
    ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
          backgroundColor: const Color.fromRGBO(9, 56, 131, 1.0),
          body: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 56,
                          color: Colors.white,
                        ),
                        Text(
                          'Something went wrong',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        Text(
                          'please try again or contact your administrator',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
    runZonedGuarded(() {
      runApp(const MaslamApp());
    }, (error, stackTrace) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    });
    //------------------------------------
  } else {
    runApp(const ErrorApp());

    // SystemNavigator.pop();
  }
}

void initOnTokenRefresh() {
  FirebaseMessaging.instance.onTokenRefresh.listen((event) {
    /// call login endpoint with latest token here
    debugPrint('TOKEN REFRESHED: $event');
  });
}

Future<String> getOrPutKey() async {
  var secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if (containsEncryptionKey) {
    var retrievedKey = await secureStorage.read(key: 'key');
    if (retrievedKey == null) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
      return await secureStorage.read(key: 'key') ?? '';
    } else {
      return retrievedKey;
    }
  } else {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    return await secureStorage.read(key: 'key') ?? '';
  }
}

Future<void> openPrivateDb() async {
  var rawKey = await getOrPutKey();
  var encryptionKey = base64Url.decode(rawKey);

  await Hive.openBox('maslamfrontdb',
      encryptionCipher: HiveAesCipher(encryptionKey));
}

class ErrorApp extends StatelessWidget {
  const ErrorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromRGBO(9, 56, 131, 1.0),
          body: Stack(
            children: [
              Positioned.fill(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 56,
                          color: Colors.white,
                        ),
                        Text(
                          'Failed to connect to server',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        Text(
                          'please try again or reopen application',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        ElevatedButton(
                            onPressed: mainBindingApp,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromRGBO(9, 56, 131, 1.0)),
                                borderRadius: BorderRadius.circular(8),
                              )),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 8),
                              child: Text(
                                'Try Again',
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color:
                                        const Color.fromRGBO(9, 56, 131, 1.0)),
                              ),
                            )),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromRGBO(9, 56, 131, 1.0)),
                                borderRadius: BorderRadius.circular(8),
                              )),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.exit_to_app,
                                      size: 18,
                                      color: Color.fromRGBO(9, 56, 131, 1.0),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Exit App',
                                      style: GoogleFonts.sourceSansPro(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: const Color.fromRGBO(
                                              9, 56, 131, 1.0)),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class MaslamApp extends StatelessWidget {
  const MaslamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.cupertino,
      initialRoute: SplashPage.routeName,
      getPages: [
        GetPage(
            name: SplashPage.routeName,
            page: () => const SplashPage(),
            binding: SplashBinding()),
        GetPage(
            name: MainWrapperPage.routeName,
            page: () => MainWrapperPage(),
            binding: MainWrapperBinding()),
        GetPage(
            name: AccountPage.routeName,
            page: () => const AccountPage(),
            binding: AccountBinding()),
        GetPage(
            name: WargaPage.routeName,
            page: () => WargaPage(),
            binding: WargaBinding()),
        GetPage(
            name: EditProfileWargaPage.routeName,
            page: () => EditProfileWargaPage(),
            binding: EditProfileWargaBinding()),
        GetPage(
            name: EditProfesionalWargaPage.routeName,
            page: () => EditProfesionalWargaPage(),
            binding: EditProfesionalWargaBinding()),
        GetPage(
            name: EditStatusWargaPage.routeName,
            page: () => EditStatusWargaPage(),
            binding: EditStatusWargaBinding()),
        GetPage(
            name: EditAlamatTeleponPage.routeName,
            page: () => EditAlamatTeleponPage(),
            binding: EditAlamatTeleponBinding()),
        GetPage(
            name: HomePage.routeName,
            page: () => const HomePage(),
            binding: HomeBinding()),
        GetPage(
            name: LoginPage.routeName,
            page: () => LoginPage(),
            binding: LoginBinding()),
        GetPage(
            name: SignUpPage.routeName,
            page: () => SignUpPage(),
            binding: SignUpBinding()),
        GetPage(
            name: OtpGmailPage.routeName,
            page: () => OtpGmailPage(),
            binding: OtpGmailBinding()),
        GetPage(
            name: LogoutPage.routeName,
            page: () => const LogoutPage(),
            binding: LogoutBinding(),
            transition: Transition.fade),
        GetPage(
            name: ChangePasswordPage.routeName,
            page: () => ChangePasswordPage(),
            binding: ChangePasswordBinding()),
        GetPage(
            name: ResetPasswordPage.routeName,
            page: () => ResetPasswordPage(),
            binding: ResetPasswordBinding()),
        GetPage(name: AboutPage.routeName, page: () => AboutPage()),
        GetPage(
            name: UnderDevelopmentPage.routeName,
            page: () => const UnderDevelopmentPage()),
        GetPage(
            name: MyMasjidPage.routeName,
            page: () => const MyMasjidPage(),
            binding: MyMasjidBinding()),
        GetPage(
            name: InformasiMasjidPage.routeName,
            page: () => const InformasiMasjidPage(),
            binding: InformasiMasjidBinding()),
        GetPage(
            name: InformasiMasjidDetailPage.routeName,
            page: () => InformasiMasjidDetailPage(),
            binding: InformasiMasjidDetailBinding()),
        GetPage(
            name: InformasiKegiatanPage.routeName,
            page: () => const InformasiKegiatanPage(),
            binding: InformasiKegiatanBinding()),
        GetPage(
            name: InformasiKegiatanDetailPage.routeName,
            page: () => const InformasiKegiatanDetailPage(),
            binding: InformasiKegiatanDetailBinding()),
        GetPage(
            name: CameraPage.routeName,
            page: () => const CameraPage(),
            binding: CameraBinding()),
        GetPage(
            name: PhotoPreviewPage.routeName,
            page: () => const PhotoPreviewPage(),
            binding: PhotoPreviewBinding()),
        GetPage(
            name: PasswordAuthPage.routeName,
            page: () => const PasswordAuthPage(),
            binding: PasswordAuthBinding()),
      ],
    );
  }
}
