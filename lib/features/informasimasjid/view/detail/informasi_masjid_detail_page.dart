import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:latlong2/latlong.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../commons/result.dart';
import '../widgets/masjid_pengurus_list_widget.dart';
import 'informasi_masjid_detail_controller.dart';

enum _MenuValues {
  addbookmark,
  removebookmark,
  jamaah,
  bagikan,
}

class InformasiMasjidDetailPage
    extends GetView<InformasiMasjidDetailController> {
  static const routeName = '/informasi-masjid-detail';

  InformasiMasjidDetailPage({Key? key}) : super(key: key);

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

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

  Widget optionBarReqJamaah(BuildContext context) =>
      PopupMenuButton<_MenuValues>(
        enableFeedback: true,
        icon: const Icon(Icons.more_vert_outlined,
            color: Color.fromRGBO(243, 204, 145, 1)),
        itemBuilder: (BuildContext context) => [
          controller.isBookmark
              ? PopupMenuItem(
                  value: _MenuValues.removebookmark,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/mosque.png',
                        color: const Color.fromARGB(255, 159, 18, 18),
                        width: 16.0,
                        height: 16.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Remove Bookmark',
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromARGB(255, 159, 18, 18),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : PopupMenuItem(
                  value: _MenuValues.addbookmark,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/mosque.png',
                        color: const Color.fromRGBO(9, 56, 131, 1.0),
                        width: 16.0,
                        height: 16.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Bookmark Masjid',
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(9, 56, 131, 1.0),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
          PopupMenuItem(
            value: _MenuValues.jamaah,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/jamaah.png',
                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                  width: 16.0,
                  height: 16.0,
                ),
                const SizedBox(width: 8),
                Text(
                  'Daftar sebagai Jamaah',
                  style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(9, 56, 131, 1.0),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            value: _MenuValues.bagikan,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/share.png',
                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                  width: 16.0,
                  height: 16.0,
                ),
                const SizedBox(width: 8),
                Text(
                  'Bagikan',
                  style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(9, 56, 131, 1.0),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case _MenuValues.addbookmark:
              controller.onTapSelectedMenu('addbookmark');
              break;
            case _MenuValues.removebookmark:
              controller.onTapSelectedMenu('rembookmark');
              break;
            case _MenuValues.jamaah:
              controller.onTapSelectedMenu('reqjamaah');
              break;
            case _MenuValues.bagikan:
              controller.onTapSelectedMenu('bagikan');
              break;
          }
        },
      );

  Widget optionBarJamaah(BuildContext context) => PopupMenuButton<_MenuValues>(
        enableFeedback: true,
        icon: const Icon(Icons.more_vert_outlined,
            color: Color.fromRGBO(243, 204, 145, 1)),
        itemBuilder: (BuildContext context) => [
          controller.isBookmark
              ? PopupMenuItem(
                  value: _MenuValues.removebookmark,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/mosque.png',
                        color: const Color.fromARGB(255, 159, 18, 18),
                        width: 16.0,
                        height: 16.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Remove Bookmark',
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromARGB(255, 159, 18, 18),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : PopupMenuItem(
                  value: _MenuValues.addbookmark,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/mosque.png',
                        color: const Color.fromRGBO(9, 56, 131, 1.0),
                        width: 16.0,
                        height: 16.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Bookmark Masjid',
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(9, 56, 131, 1.0),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
          PopupMenuItem(
            value: _MenuValues.bagikan,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/share.png',
                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                  width: 16.0,
                  height: 16.0,
                ),
                const SizedBox(width: 8),
                Text(
                  'Bagikan',
                  style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(9, 56, 131, 1.0),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case _MenuValues.addbookmark:
              controller.onTapSelectedMenu('addbookmark');
              break;
            case _MenuValues.removebookmark:
              controller.onTapSelectedMenu('rembookmark');
              break;
            case _MenuValues.jamaah:
              controller.onTapSelectedMenu('reqjamaah');
              break;
            case _MenuValues.bagikan:
              controller.onTapSelectedMenu('bagikan');
              break;
          }
        },
      );

  Widget bottomWidget(BuildContext context, double scale) => Container(
      height: 68,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12 * scale, 0, 8, 8),
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
                  'Informasi Masjid',
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
              controller.isJamaah
                  ? optionBarJamaah(context)
                  : optionBarReqJamaah(context),
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
        count: controller.masjidBannerList.data!.length,
        effect: const WormEffect(
            dotWidth: 10,
            dotHeight: 10,
            activeDotColor: Color.fromRGBO(243, 204, 145, 1.0)),
      );

  Widget bannerSlide(double scale) {
    switch (controller.masjidBannerList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        if (controller.masjidBannerList.data!.isNotEmpty) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      itemCount: controller.masjidBannerList.data!.length,
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
                        final urlImage =
                            controller.masjidBannerList.data![index].urlImage;
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

  Widget menuItem(String img, String label, double scale) {
    return GestureDetector(
        onTap: () {
          controller.onTapMenu(label); // Call the onTapMenu function with the specific label.
        },
        child: Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            width: 100 * scale,
            height: 48 * scale,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    img,
                    alignment: Alignment.topCenter,
                    width: 36 * scale,
                    height: 36 * scale,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 10,
                              color: Colors.grey[800],
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
        padding: EdgeInsets.symmetric(horizontal: 20 * scale),
        width: double.infinity,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                menuItem('assets/icons/home_bank.png', 'Keuangan', scale),
                menuItem('assets/icons/home_jamaah.png', 'Data Jamaah', scale),
                menuItem('assets/icons/home_fitri.png', 'Idul Fitri', scale),
              ]),
        ]));
  }

  Widget expansionDetailDescription(BuildContext context, double scale) {
    switch (controller.masjidDescription.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        return ListTile(
          title: Text(
            controller.masjidDescription.data!.profile,
            textAlign: TextAlign.start,
            style: GoogleFonts.sourceSansPro(
                fontSize: 12, color: Colors.grey[600]),
          ),
        );
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

  Widget expansionDescription(BuildContext context, double scale) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text(
          'Deskripsi',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: 'FuturaMdBT',
              // fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color.fromRGBO(9, 56, 131, 1.0)),
        ),
        children: <Widget>[expansionDetailDescription(context, scale)],
      ),
    );
  }

  Widget expansionDetailDKM(BuildContext context, double scale) {
    switch (controller.masjidPengurusList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        if (controller.masjidPengurusList.data!.isNotEmpty) {
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
                        return MasjidPengurusListWidget(
                          nama: controller.masjidPengurusList.data![index].nama,
                          jabatan: controller
                              .masjidPengurusList.data![index].jabatan,
                          scale: scale,
                        );
                      },
                      itemCount: controller.masjidPengurusList.data!.length),
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

  Widget expansionDKM(BuildContext context, double scale) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: const Text(
          'Dewan Kemakmuram Masjid (DKM)',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: 'FuturaMdBT',
              // fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color.fromRGBO(9, 56, 131, 1.0)),
        ),
        children: <Widget>[expansionDetailDKM(context, scale)],
      ),
    );
  }

  Widget expansionDetailPeta(BuildContext context, double scale) {
    switch (controller.masjidDetail.status) {
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
                      center: LatLng(controller.masjidDetail.data!.latitude,
                          controller.masjidDetail.data!.longitude),
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
                                controller.masjidDetail.data!.latitude,
                                controller.masjidDetail.data!.longitude),
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
    return Theme(
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
    );
  }

  Widget listExpansion(BuildContext context, double scale) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16 * scale),
      // padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
      child: Column(children: [
        expansionDescription(context, scale),
        expansionDKM(context, scale),
        expansionPeta(context, scale),
      ]),
    );
  }

  Widget tabKontak(BuildContext context, double scale) {
    switch (controller.masjidKontakList.status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(9, 56, 131, 1.0),
          ),
        );
      case Status.success:
        return Container(
            margin: EdgeInsets.fromLTRB(
                16 * scale, 20 * scale, 16 * scale, 20 * scale),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            child: ListView.builder(
                itemCount: controller.masjidKontakList.data!.length,
                itemBuilder: (context, rowIndex) {
                  return Column(children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                controller
                                    .masjidKontakList.data![rowIndex].icon,
                                width: 24.0,
                                height: 24.0,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                controller.masjidKontakList.data![rowIndex]
                                    .sosmedNama,
                                style: const TextStyle(
                                  color: Color.fromRGBO(130, 130, 130, 1),
                                  fontSize: 14,
                                  fontFamily: 'Futura Bk BT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 50),
                          Expanded(
                              child: Text(
                            controller.masjidKontakList.data![rowIndex].url,
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              color: Color.fromRGBO(174, 174, 174, 1),
                              fontSize: 12,
                              fontFamily: 'Arial',
                              fontWeight: FontWeight.w400,
                            ),
                            // maxLines: 2,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ]);
                }));
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

  Widget tabFasilitas(BuildContext context, double scale) {
    switch (controller.masjidFasilitasList.status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(9, 56, 131, 1.0),
          ),
        );
      case Status.success:
        return Container(
            margin: EdgeInsets.fromLTRB(
                16 * scale, 20 * scale, 16 * scale, 20 * scale),
            padding: EdgeInsets.symmetric(horizontal: 5 * scale),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            child: ListView.builder(
                itemCount:
                    (controller.masjidFasilitasList.data!.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  final leftIndex = rowIndex * 2;
                  final rightIndex = leftIndex + 1;

                  // Check if the right item exists (last row might have only one item)
                  final hasRightItem =
                      rightIndex < controller.masjidFasilitasList.data!.length;

                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items to the top
                      children: [
                        Expanded(
                          child: hasRightItem
                              ? ListTile(
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        controller.masjidFasilitasList
                                            .data![leftIndex].icon,
                                        width: 24.0 * scale,
                                        height: 24.0 * scale,
                                        color: const Color.fromRGBO(
                                            9, 56, 131, 1.0),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        controller.masjidFasilitasList
                                            .data![leftIndex].namaFasilitas,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(130, 130, 130, 1),
                                          fontSize: 14,
                                          fontFamily: 'Futura Bk BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: hasRightItem
                              ? ListTile(
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        controller.masjidFasilitasList
                                            .data![rightIndex].icon,
                                        width: 24.0 * scale,
                                        height: 24.0 * scale,
                                        color: const Color.fromRGBO(
                                            9, 56, 131, 1.0),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        controller.masjidFasilitasList
                                            .data![rightIndex].namaFasilitas,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(130, 130, 130, 1),
                                          fontSize: 14,
                                          fontFamily: 'Futura Bk BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ]);
                }));
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

  Widget tabKegiatan(BuildContext context, double scale) {
    switch (controller.masjidKegiatanList.status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(9, 56, 131, 1.0),
          ),
        );
      case Status.success:
        return Container(
            margin: EdgeInsets.fromLTRB(
                16 * scale, 20 * scale, 16 * scale, 20 * scale),
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            child: ListView.builder(
                itemCount:
                    (controller.masjidKegiatanList.data!.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  final leftIndex = rowIndex * 2;
                  final rightIndex = leftIndex + 1;

                  final hasRightItem =
                      rightIndex < controller.masjidKegiatanList.data!.length;

                  return Column(children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: hasRightItem
                              ? ListTile(
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        controller.masjidKegiatanList
                                            .data![leftIndex].icon,
                                        width: 24.0 * scale,
                                        height: 24.0 * scale,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        controller.masjidKegiatanList
                                            .data![leftIndex].nama,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(130, 130, 130, 1),
                                          fontSize: 14,
                                          fontFamily: 'Futura Bk BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: hasRightItem
                              ? ListTile(
                                  title: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        controller.masjidKegiatanList
                                            .data![rightIndex].icon,
                                        width: 24.0 * scale,
                                        height: 24.0 * scale,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: Text(
                                        controller.masjidKegiatanList
                                            .data![rightIndex].nama,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(130, 130, 130, 1),
                                          fontSize: 14,
                                          fontFamily: 'Futura Bk BT',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ]);
                }));
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

  Widget tablistInfoMasjid(BuildContext context, double scale) {
    return Column(children: [
      TabBar(
        controller: controller.tabInfoMasjidController,
        labelColor: const Color.fromRGBO(9, 56, 131, 1.0),
        labelStyle: const TextStyle(
            fontFamily: 'FuturaMdBT',
            fontWeight: FontWeight.w400,
            fontSize: 14),
        unselectedLabelColor: Colors.grey[400],
        indicatorColor: const Color.fromRGBO(245, 214, 167, 1.0),
        tabs: const [
          Tab(text: 'Kontak'),
          Tab(text: 'Fasilitas'),
          Tab(text: 'Program'),
        ],
      ),
      SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: TabBarView(
            controller: controller.tabInfoMasjidController,
            children: [
              tabKontak(context, scale),
              tabFasilitas(context, scale),
              tabKegiatan(context, scale)
            ],
          ))
    ]);
  }

  Widget buildBody(BuildContext context, double scale) {
    switch (controller.masjidDetail.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(9, 56, 131, 1.0)));
      case Status.success:
        return Stack(children: [
          SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // const SizedBox(
                //   height: 15,
                // ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
                        child: Text(
                          controller.masjidDetail.data!.nama,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontFamily: 'FuturaMdBT',
                              // fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(9, 56, 131, 1.0)),
                        )),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            controller.onTapLike();
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 18 * scale),
                            alignment: Alignment.centerRight,
                            child: controller.isLike
                                ? Image.asset(
                                    'assets/icons/heart.png',
                                    width: 24.0,
                                    height: 24.0,
                                  )
                                : Image.asset('assets/icons/heart.png',
                                    width: 24.0,
                                    height: 24.0,
                                    color: Colors.grey),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => bannerSlide(scale)),
                const SizedBox(height: 20),
                listMenu(scale),
                const SizedBox(height: 20),
                listExpansion(context, scale),
                const SizedBox(height: 10),
                tablistInfoMasjid(context, scale),
              ])),
          Visibility(
              visible: controller.isLoading, child: bigLoadingIndicator())
        ]);
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
                preferredSize: const Size.fromHeight(68),
                child: Obx(
                  () => bottomWidget(context, screenScale),
                ))),
        body: RefreshIndicator(
            color: const Color.fromRGBO(7, 56, 130, 1.0),
            onRefresh: () async => controller.fetchData(),
            child: Obx(() => buildBody(context, screenScale))));
  }

  Widget bigLoadingIndicator() => Container(
      color: loadingBackgroundColor,
      child: Center(
          child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: const Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(9, 56, 131, 1.0))),
        ),
      )));
}
