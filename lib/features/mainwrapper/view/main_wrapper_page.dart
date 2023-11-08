// ignore_for_file: unused_import

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../consts/binding_const.dart';
import '../../../utils/navigator_util.dart';
import '../../home/view/home_page.dart';

import '../../login/data/datasources/auth_datasource.dart';
import 'main_wrapper_controller.dart';

// class MainWrapperPage extends GetView<MainWrapperController> {
class MainWrapperPage extends StatelessWidget {
  static const routeName = '/main-wrapper';
  MainWrapperPage({Key? key}) : super(key: key);

  final MainWrapperController controller = Get.put(MainWrapperController(Get.find<AuthDatasource>(tag: defaultAuthTag)), permanent: false);

  GetPageRoute? getPageRoute;

  buildBottomNavigationMenu(BuildContext context, MainWrapperController controller){
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png',
                  fit: BoxFit.fill, width: 25, height: 25),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/donation.png',
                  fit: BoxFit.fill, width: 25, height: 25),
              label: 'Donasi',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/mosque.png',
                  fit: BoxFit.fill, width: 25, height: 25),
              label: 'My Masjid',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/beads.png',
                  fit: BoxFit.fill, width: 25, height: 25),
              label: 'My Activity',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/profile.png',
                  fit: BoxFit.fill, width: 25, height: 25),
              label: 'Akun',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: const Color.fromRGBO(7, 56, 130, 1.0),
          selectedFontSize: 14,
          unselectedItemColor: const Color.fromRGBO(107, 107, 107, 1),
          unselectedFontSize: 12,
          // showUnselectedLabels: true,
          onTap: controller.onTapBottomSheetItem,
        )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Navpage.mainListNav,
        pages: controller.pages,
        initialRoute: HomePage.routeName,
        onGenerateRoute: (settings){
          controller.onGenerateRoute(
              settings,
              feedBack: (pageRoute){
                getPageRoute = pageRoute;
              },
          );

          return getPageRoute;
        },
      ),
      bottomNavigationBar: buildBottomNavigationMenu(context, controller),
    );
  }
}
