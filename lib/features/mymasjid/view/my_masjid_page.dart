import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/models/my_masjid_list.dart';
import 'my_masjid_controller.dart';
import 'widgets/my_masjid_list_widget.dart';

class MyMasjidPage extends GetView<MyMasjidController> {
  static const routeName = '/my-masjid';

  const MyMasjidPage({Key? key}) : super(key: key);

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
                  (BuildContext context, MyMasjidList item, int index) =>
                      GestureDetector(
                        onTap: () {
                          controller.onTapMasjidDetail(item.masjidId);
                        },
                        child: MasjidListWidget(
                          urlImage: item.urlImage,
                          namaMasjid: item.namaMasjid,
                          alamat: item.alamat,
                          namaKelurahan: item.namaKelurahan,
                          namaKecamatan: item.namaKecamatan,
                          namaKota: item.namaKota,
                          isJamaah: item.isJamaah,
                          isBookmark: item.isBookmark,
                          isLike: item.isLike,
                          aksi: item.aksi,
                          ketAksi: item.keteranganAksi,
                        ),
                      ),
              noItemsFoundIndicatorBuilder: (context) => buildEmptyState()),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 4),
        ),
      );

  Widget searchBar() => Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
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
                onChanged: (value) => controller.onChangeSearchTextField(value),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.withOpacity(0.7),
                ),
                cursorColor: const Color.fromRGBO(117, 117, 117, 1.0),
                decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Cari Masjid',
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

  Widget bottomWidget() => Container(
      height: 116,
      color: Colors.white,
      // decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //   BoxShadow(
      //       offset: const Offset(0, 4),
      //       color: Color.fromARGB(255, 246, 7, 7).withOpacity(0.03),
      //       blurRadius: 7)
      // ]),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Row(children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'My Masjid',
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
            const SizedBox(
              height: 12,
            ),
            searchBar(),
          ],
        ),
      ));

  Future<bool> onWillPop() {
    controller.onTapBack(0);

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
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
                preferredSize: const Size.fromHeight(116),
                child: bottomWidget())),
        body: RefreshIndicator(
            color: const Color.fromRGBO(7, 56, 130, 1.0),
            onRefresh: () async => controller.onRefresh(),
            child: buildBody())));
  }
}
