import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../commons/result.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  static const routeName = '/account';

  const AccountPage({Key? key}) : super(key: key);

  Widget defaultPhoto() => ClipOval(
        child: Image.asset(
          'assets/icons/def_user.png',
          width: 60,
          height: 60,
        ),
      );

  Widget accountUser() {
    switch (controller.dataWarga.status) {
      case Status.loading:
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 9,
                children: [
                  Container(
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromRGBO(9, 56, 131, 1.0),
                      )))
                ]));
      case Status.success:
        return Container(
          // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border:
                  Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
          child: Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 9,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipOval(
                        child: Image.network(
                            controller.dataWarga.data!.namaFile,
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, widget, progress) =>
                                progress == null ? widget : defaultPhoto(),
                            errorBuilder: (context, widget, stackTrace) {
                              debugPrint('ERROR IMG: $stackTrace');
                              return defaultPhoto();
                            }),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.dataWarga.data!.nama,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[600]),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.dataWarga.data!.email,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.grey[400]),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                controller.dataWarga.data!.noHp,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.grey[400]),
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     controller.dataWarga.data!.alamatRumah,
                            //     textAlign: TextAlign.start,
                            //     style: GoogleFonts.sourceSansPro(
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 11,
                            //         color: Colors.grey[400]),
                            //   ),
                            // ),
                            // const SizedBox(height: 5),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Member sejak tahun ${controller.dataWarga.data!.memberSince}',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.grey[400]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.onTapEditWargaProfil();
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            child: Row(
                              children: [
                                Text(
                                  'Edit',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: Colors.grey[400]),
                                ),
                                const SizedBox(width: 2),
                                Image.asset('assets/icons/edit.png',
                                    //color: const Color.fromRGBO(249, 249, 249, 1.0),
                                    width: 12,
                                    height: 12),
                              ],
                            ),
                          )),
                      const SizedBox(width: 5),
                    ],
                  ),
                )
              ]),
        );
      case Status.error:
        return const SizedBox();
    }
  }

  Widget accountEmail() {
    switch (controller.dataWarga.status) {
      case Status.loading:
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            child: Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 9,
                children: [
                  Container(
                      height: 100,
                      padding: const EdgeInsets.all(12),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Color.fromRGBO(9, 56, 131, 1.0),
                      )))
                ]));
      case Status.success:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              border:
                  Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 0.2, color: Color.fromRGBO(20, 124, 220, 1)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Akun',
                        style: TextStyle(
                          color: Color.fromRGBO(20, 124, 220, 1),
                          fontSize: 14,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // const SizedBox(width: 84),
                      Row(
                        children: [
                          Text(
                            'Edit',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.grey[400]),
                          ),
                          const SizedBox(width: 2),
                          Image.asset('assets/icons/edit.png',
                              //color: const Color.fromRGBO(249, 249, 249, 1.0),
                              width: 12,
                              height: 12),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.2, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      const Text(
                        'No Telp',
                        style: TextStyle(
                          color: Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 14,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 70),
                      Text(
                        controller.dataWarga.data!.noHp,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 14,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.2, color: Colors.grey),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16),
                      const Text(
                        'Email',
                        style: TextStyle(
                          color: Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 14,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 84),
                      Text(
                        controller.dataWarga.data!.email,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 14,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case Status.error:
        return const SizedBox();
    }
  }

  Widget accountSettingMenus() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border:
                Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.2, color: Color.fromRGBO(20, 124, 220, 1)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Color.fromRGBO(20, 124, 220, 1),
                    fontSize: 14,
                    fontFamily: 'FuturaMdBT',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.vpn_key,
                size: 20, color: Color.fromRGBO(9, 56, 131, 1.0)),
            title: const Text(
              'Ubah Password',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(174, 174, 174, 1),
                fontSize: 14,
                fontFamily: 'FuturaMdBT',
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () => controller.onTapChangePassword(),
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded,
                size: 20, color: Color.fromRGBO(9, 56, 131, 1.0)),
            title: const Text(
              'About',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color.fromRGBO(174, 174, 174, 1),
                fontSize: 14,
                fontFamily: 'FuturaMdBT',
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () => controller.onTapAbout(),
          ),
          Container(
            color: const Color.fromRGBO(244, 245, 247, 1.0),
            width: double.infinity,
            height: 2,
          ),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                stops: [0.1, 0.85],
                colors: [
                  Color.fromRGBO(9, 56, 131, 1.0),
                  Color.fromRGBO(9, 56, 131, 1.0)
                ],
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: ListView(
          addAutomaticKeepAlives: true,
          children: [
            // Obx(() => buildHeader()),
            // buildHeader(),
            const SizedBox(height: 24),
            const Center(
                child: Text(
              'Akun',
              style: TextStyle(
                color: Color(0xFF565656),
                fontSize: 18,
                fontFamily: 'FuturaMdBT',
                fontWeight: FontWeight.w400,
              ),
            )),
            const SizedBox(height: 16),
            Obx(() => accountUser()),
            const SizedBox(height: 10),
            // Obx(() => accountEmail()),
            // const SizedBox(height: 10),
            accountSettingMenus(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: controller.onTapSignOutButton,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(9, 56, 131, 1.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 4),
                      child: Text(
                        'Sign out',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.summarize_outlined,
              size: 56,
              color: Color.fromRGBO(9, 56, 131, 1.0),
            ),
            const SizedBox(height: 12),
            Text(
              'No data found',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]),
        ),
      );
}
