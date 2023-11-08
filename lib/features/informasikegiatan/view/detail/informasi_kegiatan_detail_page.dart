import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:latlong2/latlong.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../commons/result.dart';
import 'informasi_kegiatan_detail_controller.dart';

class InformasiKegiatanDetailPage
    extends GetView<InformasiKegiatanDetailController> {
  static const routeName = '/informasi-kegiatan-detail';

  const InformasiKegiatanDetailPage({Key? key}) : super(key: key);

  Widget buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.list_alt,
              size: 56,
              color: Color.fromRGBO(7, 56, 130, 1.0),
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

  Widget bottomWidget() => Container(
      height: 60,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                  onTap: controller.onTapBackButton,
                  child: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.grey)),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Kegiatan Masjid',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'FuturaMdBT',
                      fontSize: 20,
                      color: Colors.black54),
                ),
              )),
              const SizedBox(
                width: 12,
              ),
              Container(
                alignment: Alignment.center,
                // padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                margin: const EdgeInsets.only(right: 12),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 1,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/icons/favorite.png',
                  width: 24.0,
                  height: 35.0,
                ),
              ),
            ]),
          ],
        ),
      ));

  Widget buildImage(String urlImage, int index, double scale) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(urlImage, width: 328 * scale, fit: BoxFit.cover),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: controller.activeIndex,
        count: controller.kegiatanBannerList.data!.length,
        effect: const WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Color.fromRGBO(243, 204, 145, 1.0)),
      );

  Widget bannerSlide(double scale) {
    switch (controller.kegiatanBannerList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        if (controller.kegiatanBannerList.data!.isNotEmpty) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      itemCount: controller.kegiatanBannerList.data!.length,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            controller.changeIndex(index),
                        height: 155 * scale,
                        initialPage: 0,
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = controller
                                    .kegiatanBannerList.data![index].urlImage ==
                                ''
                            ? controller
                                .kegiatanBannerList.data![index].urlImageMaster
                            : controller
                                .kegiatanBannerList.data![index].urlImage;
                        return buildImage(urlImage, index, scale);
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

  Widget detailKegiatan(double scale) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(16 * scale, 0, 16 * scale, 0),
        // padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        width: double.infinity,
        // height: 324,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                      child: Text(
                        controller.kegiatanDetail.data!.judul,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontFamily: 'FuturaMdBT',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(9, 56, 131, 1.0)),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
                      child: Text(
                        controller.kegiatanDetail.data!.deskripsi,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontFamily: 'FuturaMdBT',
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromRGBO(174, 174, 174, 1)),
                      )),
                  const SizedBox(height: 12),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.4, color: Colors.grey),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24 * scale),
                      child: Row(
                        children: [
                          SizedBox(width: 8 * scale),
                          Image.asset(
                            'assets/icons/masjid.png',
                            width: 20.0 * scale,
                            height: 20.0 * scale,
                          ),
                          SizedBox(width: 75 * scale),
                          Text(
                            controller.kegiatanDetail.data!.tempat,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontFamily: 'FuturaMdBT',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Color.fromRGBO(174, 174, 174, 1)),
                          )
                        ],
                      )),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.4, color: Colors.grey),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24 * scale),
                      child: Row(
                        children: [
                          SizedBox(width: 8 * scale),
                          Image.asset(
                            'assets/icons/calendar.png',
                            width: 20.0 * scale,
                            height: 20.0 * scale,
                          ),
                          SizedBox(width: 75 * scale),
                          Text(
                            controller.kegiatanDetail.data!.tanggalDanJam,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'FuturaMdBT',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Color.fromRGBO(174, 174, 174, 1)),
                          )
                        ],
                      )),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.4, color: Colors.grey),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 24 * scale),
                      child: Row(
                        children: [
                          SizedBox(width: 8 * scale),
                          Image.asset(
                            'assets/icons/ticket.png',
                            width: 20.0 * scale,
                            height: 20.0 * scale,
                          ),
                          SizedBox(width: 75 * scale),
                          Text(
                            controller.kegiatanDetail.data!.isBayar
                                ? controller.kegiatanDetail.data!.biaya
                                    .toString()
                                : 'Gratis untuk Umum',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'FuturaMdBT',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: Color.fromRGBO(99, 213, 152, 1)),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ));
  }

  Widget popUpPembicara(BuildContext context, double scale, String nama,
      String jk, String profil, String urlFoto) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Stack(
        // alignment: Alignment.topCenter,
        children: [
          // Positioned(
          //   top: -60,
          //   child: CircleAvatar(
          //     radius: 60,
          //     backgroundColor: Colors.white,
          //     backgroundImage: NetworkImage(urlFoto),
          //     // child:
          //     // ClipOval(
          //     //   child: Image.network(
          //     //     urlFoto,
          //     //     width: 130,
          //     //     height: 130,
          //     //     fit: BoxFit.cover,
          //     //   ),
          //     // )
          //   ),
          // ),
          IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.fromLTRB(16 * scale, 8, 16 * scale, 8),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                ClipOval(
                  child: Image.network(
                    urlFoto,
                    width: 130,
                    height: 130,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'FuturaMdBT',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color.fromRGBO(9, 56, 131, 1.0)),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  profil,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontFamily: 'FuturaMdBT',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color.fromRGBO(174, 174, 174, 1)),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget listPembicara(BuildContext context, double scale, String nama,
      String jk, String profil, String urlFoto) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return popUpPembicara(
                    context, scale, nama, jk, profil, urlFoto);
              });
        },
        child: Container(
          width: 288 * scale,
          height: 36,
          padding: const EdgeInsets.symmetric(vertical: 8),
          // margin: EdgeInsets.fromLTRB(20 * scale, 0, 8 * scale, 0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.4, color: Colors.grey),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 8 * scale),
              jk == 'L'
                  ? Image.asset(
                      'assets/icons/ustadz.png',
                      width: 20.0 * scale,
                      height: 20.0 * scale,
                    )
                  : Image.asset(
                      'assets/icons/ustadzah.png',
                      width: 20.0 * scale,
                      height: 20.0 * scale,
                    ),
              SizedBox(width: 75 * scale),
              Expanded(
                  child: Text(
                nama,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'FuturaMdBT',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color.fromRGBO(9, 56, 131, 1.0)),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ));
  }

  Widget buildPembicara(BuildContext context, double scale) {
    switch (controller.kegiatanPembicaraList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        if (controller.kegiatanPembicaraList.data!.isNotEmpty) {
          return Container(
              // padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.symmetric(horizontal: 24 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return listPembicara(
                          context,
                          scale,
                          controller
                              .kegiatanPembicaraList.data![index].pembicaraNama,
                          controller.kegiatanPembicaraList.data![index]
                              .jenisKelaminKode,
                          controller.kegiatanPembicaraList.data![index].profil,
                          controller.kegiatanPembicaraList.data![index]
                                      .namaFile ==
                                  ''
                              ? controller.kegiatanPembicaraList.data![index]
                                  .namaFileDefault
                              : controller
                                  .kegiatanPembicaraList.data![index].namaFile,
                        );
                      },
                      itemCount: controller.kegiatanPembicaraList.data!.length),
                  const SizedBox(height: 10),
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

  Widget expansionPembicara(BuildContext context, double scale) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 16 * scale),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border:
                Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
        child: Column(children: [
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: const Text(
                'Pembicara',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'FuturaMdBT',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color.fromRGBO(9, 56, 131, 1.0)),
              ),
              children: <Widget>[buildPembicara(context, scale)],
            ),
          )
        ]));
  }

  Widget expansionDetailPeta(BuildContext context, double scale) {
    switch (controller.kegiatanDetail.status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(9, 56, 131, 1.0),
          ),
        );
      case Status.success:
        return Column(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8),
              width: 350 * scale,
              height: 200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(controller.kegiatanDetail.data!.latitude,
                          controller.kegiatanDetail.data!.longitude),
                      zoom: 15.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 30.0,
                            height: 30.0,
                            point: LatLng(
                                controller.kegiatanDetail.data!.latitude,
                                controller.kegiatanDetail.data!.longitude),
                            builder: (ctx) => const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        );
      case Status.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget expansionPeta(BuildContext context, double scale) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16 * scale),
      // padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
      child: Column(children: [
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text(
              'Peta Lokasi',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'FuturaMdBT',
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromRGBO(9, 56, 131, 1.0)),
            ),
            children: <Widget>[expansionDetailPeta(context, scale)],
          ),
        )
      ]),
    );
  }

  Widget buildBody(BuildContext context, double scale) {
    switch (controller.kegiatanDetail.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 15,
          ),
          Obx(() => bannerSlide(scale)),
          const SizedBox(height: 20),
          detailKegiatan(scale),
          const SizedBox(height: 10),
          expansionPembicara(context, scale),
          const SizedBox(height: 10),
          expansionPeta(context, scale),
          const SizedBox(height: 10),
        ]));
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

  @override
  Widget build(BuildContext context) {
    double screenScale = MediaQuery.of(context).size.width / 360;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
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
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: bottomWidget())),
        body: RefreshIndicator(
            color: const Color.fromRGBO(7, 56, 130, 1.0),
            onRefresh: () async => controller.fetchData(),
            child: Obx(() => buildBody(context, screenScale))));
  }
}
