import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/date_formatter.dart';
import '../../../commons/result.dart';
import '../../informasimasjid/view/widgets/masjid_list_widget.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  Widget nextPray() {
    switch (controller.nearestPrayTime.status) {
      case Status.loading:
        return const SizedBox();
      case Status.success:
        return Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(20, 7, 0, 0),
            width: 180,
            child: FittedBox(
                child: Text(
              '${controller.nearestPrayTime.data!.waktuSholat} ${controller.nearestPrayTime.data!.waktu}',
              textAlign: TextAlign.end,
              style: GoogleFonts.sourceSansPro(
                  color: const Color.fromRGBO(20, 124, 220, 1.0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )));
      case Status.error:
        return const SizedBox();
    }
  }

  Widget nextPrayTabSholat(double scale) {
    switch (controller.nearestPrayTime.status) {
      case Status.loading:
        return const SizedBox();
      case Status.success:
        return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(2 * scale, 0, 0, 0),
            width: 150,
            child: FittedBox(
                child: Text(
              '${controller.nearestPrayTime.data!.waktuSholat} ${controller.nearestPrayTime.data!.waktu}',
              textAlign: TextAlign.start,
              style: GoogleFonts.sourceSansPro(
                  color: const Color.fromRGBO(20, 124, 220, 1.0),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )));
      case Status.error:
        return const SizedBox();
    }
  }

  Widget waktuSholatMendatang(double scale) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 0),
        padding: EdgeInsets.fromLTRB(12 * scale, 10, 0, 12 * scale),
        width: double.infinity,
        height: 84,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 1,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Obx(() => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/home_location.png',
                              width: 20.0 * scale,
                              height: 20.0 * scale,
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              // width: 150,
                              height: 40,
                              child: Text(
                                controller.placemark != null
                                    ? '${controller.placemark![0].locality}, ${controller.placemark![0].administrativeArea} '
                                    : '-',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'FuturaMdBT',
                                  color: Color.fromRGBO(9, 56, 131, 1.0),
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ],
                        ),
                        Row(children: [
                          const SizedBox(width: 2),
                          Text(
                            'Waktu Sholat Mendatang',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => nextPray()),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Obx(() => Text(
                                    // controller.countText,
                                    '${controller.remainingTime.inHours.toString().padLeft(2, '0')} :${(controller.remainingTime.inMinutes % 60).toString().padLeft(2, '0')} :${(controller.remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(
                                          237, 102, 102, 1),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
  }

  Widget waktuSholatMendatangTabSholat(double scale) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(15 * scale, 0, 17 * scale, 0),
        padding: EdgeInsets.fromLTRB(12 * scale, 8, 12 * scale, 12),
        width: double.infinity,
        height: 84,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 1,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Obx(() => controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/home_location.png',
                              width: 20 * scale,
                              height: 20 * scale,
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                              width: 150 * scale,
                              height: 40,
                              child: Text(
                                controller.placemark != null
                                    ? '${controller.placemark![0].locality}, ${controller.placemark![0].administrativeArea} '
                                    : '-',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'FuturaMdBT',
                                  color: Color.fromRGBO(9, 56, 131, 1.0),
                                  fontSize: 12,
                                  // fontWeight: FontWeight.w600,
                                ),
                                softWrap: false,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                          ],
                        ),
                        Row(children: [
                          Obx(() => nextPrayTabSholat(scale)),
                        ]),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 8, 12 * scale, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Waktu Sholat Mendatang',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Obx(() => Text(
                                    // controller.countText,
                                    '${controller.remainingTime.inHours.toString().padLeft(2, '0')} :${(controller.remainingTime.inMinutes % 60).toString().padLeft(2, '0')} :${(controller.remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                                    style: GoogleFonts.sourceSansPro(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromRGBO(
                                          237, 102, 102, 1),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
  }

  Widget sholatHariIni(BuildContext context, double scale) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 45,
          margin: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 0),
          padding: const EdgeInsets.fromLTRB(0, 0, 12, 8),
          decoration: ShapeDecoration(
            color: const Color.fromRGBO(250, 234, 211, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                iconSize: 24,
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(9, 56, 131, 1)),
                onPressed: () {
                  controller.onTapYesterday();
                },
              ),
              Obx(
                () => Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    controller.hariIni.completeDayMonthYearFormat,
                    style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(9, 56, 131, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Color.fromRGBO(9, 56, 131, 1)),
                onPressed: () {
                  controller.onTapTommorow();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) => ClipRRect(
        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
        child: Image.network(urlImage, fit: BoxFit.cover),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: controller.activeIndex,
        count: controller.bannerList.data!.length,
        effect: const WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Color.fromRGBO(243, 204, 145, 1.0)),
      );

  Widget bannerSlide(double scale) {
    switch (controller.bannerList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        if (controller.bannerList.data!.isNotEmpty) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      itemCount: controller.bannerList.data!.length,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            controller.changeIndex(index),
                        height: 173 * scale,
                        initialPage: 0,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final urlImage =
                            controller.bannerList.data![index].urlImage;
                        return buildImage(urlImage, index);
                      },
                    ),
                    const SizedBox(height: 10),
                    buildIndicator(),
                  ],
                ),
              ));
        } else {
          return buildEmptyState();
        }
      case Status.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.error,
                size: 56,
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              Text(
                'An error occurred while processing the data',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              )
            ]),
          ),
        );
    }
  }

  Widget menuItem(String img, String label, double scale) {
    return GestureDetector(
        onTap: () {
          controller.onTapMenu(label);
        },
        child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            width: 62 * scale,
            height: 80 * scale,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 1,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    img,
                    alignment: Alignment.topCenter,
                    width: 36 * scale,
                    height: 36 * scale,
                  ),
                  const SizedBox(height: 3),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 10,
                              color: Colors.grey[600],
                            ),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ]),
                  )
                ],
              ),
            )));
  }

  Widget listMenu(double scale) {
    return Container(
        padding: EdgeInsets.fromLTRB(16 * scale, 8, 16 * scale, 20),
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                menuItem('assets/icons/home_crescent.png', 'Informasi Masjid',
                    scale),
                menuItem(
                    'assets/icons/home_dome.png', 'Kegiatan Masjid', scale),
                menuItem('assets/icons/home_jamaah.png', 'Data Jamaah', scale),
                menuItem('assets/icons/home_qurban.png', 'Idul Adha & Qurban',
                    scale),
                menuItem('assets/icons/home_mustahiq.png', 'Mustahiq', scale),
              ]),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              menuItem('assets/icons/home_bank.png', 'Keuangan', scale),
              menuItem('assets/icons/home_solidaritas.png', 'Solidaritas Warga',
                  scale),
              menuItem('assets/icons/home_ziswaf.png', 'ZISWAF', scale),
              menuItem('assets/icons/home_fitri.png', 'Ramadhan & Idul Fitri',
                  scale),
              menuItem('assets/icons/home_menu_lain.png', 'Menu Lainnya', scale)
              // ]),
            ],
          )
        ]));
  }

  Widget listMasjid() {
    switch (controller.mosqueList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(9, 56, 131, 1.0),
        ));
      case Status.success:
        if (controller.mosqueList.data!.isNotEmpty) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.onTapMasjidDetail(
                                controller.mosqueList.data![index].masjidId);
                          },
                          child: MasjidListWidget(
                            urlImage:
                                controller.mosqueList.data![index].urlImage,
                            namaMasjid:
                                controller.mosqueList.data![index].namaMasjid,
                            namaKota:
                                controller.mosqueList.data![index].namaKota,
                            namaKecamatan: controller
                                .mosqueList.data![index].namaKecamatan,
                            namaKelurahan: controller
                                .mosqueList.data![index].namaKelurahan,
                            jarak: controller.mosqueList.data![index].jarak,
                            waktuTempuh:
                                controller.mosqueList.data![index].waktuTempuh,
                          ),
                        );
                      },
                      itemCount: controller.mosqueList.data!.length),
                ],
              ));
        } else {
          return buildEmptyState();
        }
      case Status.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(
                Icons.error,
                size: 56,
                color: Colors.red,
              ),
              const SizedBox(height: 12),
              Text(
                Status.error.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              )
            ]),
          ),
        );
    }
  }

  Widget showJadwalSholat(
      String jadwal, String waktu, bool sama, bool garisBawah) {
    return Container(
      width: 300,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 0.5, color: garisBawah ? Colors.grey : Colors.white),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            jadwal,
            style: TextStyle(
              color: sama
                  ? const Color.fromRGBO(68, 120, 255, 1.0)
                  : const Color.fromRGBO(174, 174, 174, 1),
              fontSize: 14,
              fontFamily: 'FuturaMdBT',
              fontWeight: sama ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          const SizedBox(width: 84),
          SizedBox(
            height: 18,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  waktu,
                  style: GoogleFonts.sourceSansPro(
                    color: sama
                        ? const Color.fromRGBO(68, 120, 255, 1.0)
                        : const Color.fromRGBO(174, 174, 174, 1),
                    fontSize: 14,
                    fontWeight: sama ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget detailSholat() {
    switch (controller.prayTime.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(9, 56, 131, 1.0),
        ));
      case Status.success:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 4),
            showJadwalSholat(
                'Imsak',
                controller.prayTime.data!.imsak,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.imsak),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Subuh',
                controller.prayTime.data!.subuh,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.subuh),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Terbit',
                controller.prayTime.data!.terbit,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.terbit),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Dzuhur',
                controller.prayTime.data!.dzuhur,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.dzuhur),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Ashar',
                controller.prayTime.data!.ashar,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.ashar),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Maghrib',
                controller.prayTime.data!.maghrib,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.maghrib),
                true),
            const SizedBox(height: 4),
            showJadwalSholat(
                'Isya',
                controller.prayTime.data!.isya,
                controller.cekWaktuSama(controller.prayTime.data!.tanggal,
                    controller.prayTime.data!.isya),
                false),
          ],
        );
      case Status.error:
        return buildEmptyState();
    }
  }

  Widget jadwalSholat(BuildContext context, double scale) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 350,
            margin: EdgeInsets.symmetric(horizontal: 16 * scale),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              shadows: const [
                BoxShadow(
                  color: Color(0x0F101828),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Obx(() => detailSholat())),
      ],
    );
  }

  Widget buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.list_alt,
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

  Widget buildErrorState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.error,
              size: 56,
              color: Colors.red,
            ),
            const SizedBox(height: 12),
            Text(
              'An error occurred while processing the data',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500),
            )
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double screenScale = MediaQuery.of(context).size.width / 360;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0.0),
              child: Image.asset('assets/logos/maslam_horizontal_logo.png',
                  width: 120, height: 40),
            ),
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(7, 56, 130, 1.0),
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () => {},
                child: Image.asset(
                  'assets/icons/search.png',
                  alignment: Alignment.center,
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 8 * (MediaQuery.of(context).size.width / 360)),
              GestureDetector(
                onTap: () => {},
                child: Image.asset(
                  'assets/icons/bell.png',
                  alignment: Alignment.center,
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 8 * (MediaQuery.of(context).size.width / 360)),
              Obx(
                () => controller.isUserSignIn
                    ? GestureDetector(
                        onTap: () => {},
                        child: Image.asset(
                          'assets/icons/burger_menu.png',
                          alignment: Alignment.center,
                          width: 24,
                          height: 24,
                        ))
                    : GestureDetector(
                        onTap: () => {controller.toLoginPage()},
                        child: const Icon(Icons.login_outlined,
                            size: 24, color: Color.fromRGBO(243, 204, 145, 1))),
              ),
              SizedBox(width: 16 * (MediaQuery.of(context).size.width / 360)),
            ],
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(children: [
                  const SizedBox(height: 10),
                  TabBar(
                    //controller: controller.tabController,
                    labelColor: const Color.fromRGBO(9, 56, 131, 1.0),
                    labelStyle: const TextStyle(
                        fontFamily: 'FuturaMdBT',
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    unselectedLabelColor: Colors.grey[400],
                    indicatorColor: const Color.fromRGBO(245, 214, 167, 1.0),
                    tabs: [
                      Tab(
                          child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: const Text('Home'),
                      )),
                      Tab(
                          child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: const Text('Sholat'),
                      )),
                    ],
                  )
                ]),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                        color: const Color.fromRGBO(7, 56, 130, 1.0),
                        onRefresh: () async => controller.getPermissionHome(),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              const SizedBox(
                                height: 15,
                              ),
                              waktuSholatMendatang(screenScale),
                              const SizedBox(
                                height: 20,
                              ),
                              Obx(() => bannerSlide(screenScale)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16 * screenScale,
                                  ),
                                  const Text(
                                    'Menu',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'FuturaMdBT',
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromRGBO(9, 56, 131, 1.0)),
                                  ),
                                ],
                              ),
                              listMenu(screenScale),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16 * screenScale,
                                  ),
                                  const Text(
                                    'Masjid Terdekat',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'FuturaMdBT',
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color.fromRGBO(9, 56, 131, 1.0)),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onTap: controller.onTapMasjidList,
                                    child: const Text(
                                      'Lihat Semua',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: 'FuturaMdBT',
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color.fromRGBO(
                                              68, 120, 255, 1.0)),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 16 * screenScale,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Obx(() => listMasjid()),
                            ]))),
                    RefreshIndicator(
                        color: const Color.fromRGBO(7, 56, 130, 1.0),
                        onRefresh: () async => controller.getPermissionSholat(),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              const SizedBox(
                                height: 20,
                              ),
                              waktuSholatMendatangTabSholat(screenScale),
                              const SizedBox(
                                height: 20,
                              ),
                              sholatHariIni(context, screenScale),
                              const SizedBox(
                                height: 20,
                              ),
                              jadwalSholat(context, screenScale)
                            ]))),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
