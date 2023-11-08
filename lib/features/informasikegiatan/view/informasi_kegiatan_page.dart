import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../commons/result.dart';
import '../../shared/master/kegiatan/models/kegiatan.dart';
import '../data/models/informasi_kegiatan.dart';
import 'informasi_kegiatan_controller.dart';
import 'widgets/kegiatan_list_widget.dart';

class InformasiKegiatanPage extends GetView<InformasiKegiatanController> {
  static const routeName = '/informasi-kegiatan';

  const InformasiKegiatanPage({Key? key}) : super(key: key);

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

  Widget buildBody() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: PagedListView.separated(
          padding: const EdgeInsets.only(top: 16),
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
              firstPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromRGBO(7, 56, 130, 1.0),
                  )),
              newPageProgressIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromRGBO(7, 56, 130, 1.0),
                  )),
              firstPageErrorIndicatorBuilder: (context) => const Center(
                      child: CircularProgressIndicator(
                    color: Color.fromRGBO(7, 56, 130, 1.0),
                  )),
              itemBuilder:
                  (BuildContext context, InformasiKegiatan item, int index) =>
                      GestureDetector(
                        onTap: () {
                          controller.onTapKegiatanDetail(item.kegiatanId);
                        },
                        child: KegiatanListWidget(
                          urlImage: item.namaFile == ''
                              ? item.namaFileMaster
                              : item.namaFile,
                          namaKegiatan: item.judul,
                          namaMasjid: item.tempat,
                          namaUstadz: item.daftarPembicara,
                          tanggalAcara: item.tanggalDanJam,
                          isBayar: item.isBayar,
                          tiket: item.biaya.toString(),
                        ),
                      ),
              noItemsFoundIndicatorBuilder: (context) => buildEmptyState()),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 4),
        ),
      );

  Widget kategoriDropdownField(double scale) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 135 * scale,
          decoration: BoxDecoration(
              border: Border(
            right: BorderSide(
              color: Colors.grey.shade300,
              width: 1.0,
            ),
          )),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            value: controller.currentKategoriQuery.value,
            items: controller.kategoriKegiatanList.data!
                .map<DropdownMenuItem<String>>((Kegiatan kategoriKegiatan) {
              return DropdownMenuItem<String>(
                value: kategoriKegiatan.nama,
                child: kategoriKegiatan.nama == 'Kategori'
                    ? Text(
                        kategoriKegiatan.nama,
                        style: const TextStyle(
                          color: Color.fromRGBO(67, 120, 255, 1),
                          fontSize: 13,
                          fontFamily: 'Source Sans Pro',
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      )
                    : Row(
                        children: [
                          Image.asset(
                            kategoriKegiatan.icon,
                            alignment: Alignment.topCenter,
                            width: 16 * scale,
                            height: 16,
                          ),
                          const SizedBox(
                              width: 4), // Adjust the spacing as needed
                          // FittedBox(
                          // child:
                          Text(
                            kategoriKegiatan.nama,
                            style: const TextStyle(
                              color: Color(0xFF4378FF),
                              fontSize: 13,
                              fontFamily: 'Source Sans Pro',
                              fontWeight: FontWeight.w400,
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                          // )
                        ],
                      ),
              );
            }).toList(),
            onChanged: (value) {
              // Make sure to update the state with the selected value
              controller.currentKategoriQuery.value = value!;
              controller.onRefresh();
            },
          ),
        ),
      ],
    );
  }

  Widget searchBar(BuildContext context, double scale) {
    switch (controller.kategoriKegiatanList.status) {
      case Status.loading:
        return const Center(
            child: CircularProgressIndicator(
          color: Color.fromRGBO(9, 56, 131, 1.0),
        ));
      case Status.success:
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  kategoriDropdownField(scale),
                  Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.searchTextController,
                      onChanged: (value) =>
                          controller.onChangeSearchTextField(value),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                      cursorColor: const Color.fromRGBO(117, 117, 117, 1.0),
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Cari Masjid, Pembicara...',
                          hintStyle: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.grey.withOpacity(0.7),
                          ),
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none),
                    ),
                  )
                ],
              ),
            ));
      case Status.error:
        return const SizedBox();
    }
  }

  Widget listOption(BuildContext context, double scale) {
    double screen = MediaQuery.of(context).size.width;
    return SizedBox(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        width: screen,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      controller.onTapOption(1);
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                        width: 92 * scale,
                        height: 40,
                        decoration: BoxDecoration(
                          color: controller.warnaTerdekat.value,
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
                                'assets/icons/location.png',
                                alignment: Alignment.topCenter,
                                width: 24 * scale,
                                height: 24 * scale,
                              ),
                              // const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Terdekat',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.sourceSansPro(
                                            fontSize: 13,
                                            color:
                                                controller.textTerdekat.value),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ))),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      controller.onTapOption(2);
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                        width: 100 * scale,
                        height: 40,
                        decoration: BoxDecoration(
                          color: controller.warnaFavorit.value,
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
                                'assets/icons/favorite.png',
                                alignment: Alignment.topCenter,
                                width: 36 * scale,
                                height: 36 * scale,
                              ),
                              // const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Favorite',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.sourceSansPro(
                                            fontSize: 13,
                                            color:
                                                controller.textFavorit.value),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ))),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {
                      controller.onTapOption(3);
                    },
                    child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                        width: 135 * scale,
                        height: 40,
                        decoration: BoxDecoration(
                          color: controller.warnaJamaah.value,
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
                                'assets/icons/mosque_yellow.png',
                                alignment: Alignment.topCenter,
                                width: 36 * scale,
                                height: 36 * scale,
                              ),
                              // const SizedBox(width: 4),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Masjid Jamaah',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.sourceSansPro(
                                            fontSize: 13,
                                            color: controller.textJamaah.value),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ))),
              ]),
        ]));
  }

  Widget bottomWidget(BuildContext context, double scale) => Container(
      height: 160,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(children: [
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
                      color: Colors.black),
                ),
              )),
              const SizedBox(
                width: 12,
              ),
            ]),

            // kategoriDropdownField(scale),
            const SizedBox(
              height: 12,
            ),
            Obx(() => searchBar(context, scale)),
            const SizedBox(
              height: 12,
            ),
            Obx(() => listOption(context, scale)),
          ],
        ),
      ));

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
                preferredSize: const Size.fromHeight(160),
                child: bottomWidget(context, screenScale))),
        body: RefreshIndicator(
            color: const Color.fromRGBO(7, 56, 130, 1.0),
            onRefresh: () async => controller.onRefresh(),
            child: buildBody()));
  }
}
