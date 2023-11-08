import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../commons/result.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../shared/asset_picker/view/asset_picker_content.dart';
import 'warga_controller.dart';

class WargaPage extends GetView<WargaController> {
  static const routeName = '/data-warga';

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  WargaPage({Key? key}) : super(key: key);

  Widget isHajiCheckboxField() => Container(
      height: 41,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 15,
          ),
          const Expanded(
            flex: 5, // Adjust the flex value to control label width
            child: Text(
              'Status Haji',
              style: TextStyle(
                color: Color.fromRGBO(174, 174, 174, 1),
                fontSize: 14,
                fontFamily: 'FuturaMdBT',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
              flex: 7,
              child: SizedBox(
                height: 35,
                width: double.infinity,
                child: Checkbox(
                    value: controller.dataWarga.data!.isHaji,
                    splashRadius: 24,
                    activeColor: Colors.white,
                    checkColor: const Color.fromRGBO(9, 56, 131, 1.0),
                    onChanged: null),
              ))
        ],
      ));

  Widget textField(String tlabel, String tkey) => Container(
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
            Expanded(
                flex: 3, // Adjust the flex value to control label width
                child: Text(
                  tlabel,
                  style: const TextStyle(
                    color: Color.fromRGBO(174, 174, 174, 1),
                    fontSize: 14,
                    fontFamily: 'FuturaMdBT',
                    fontWeight: FontWeight.w400,
                  ),
                )),
            //const SizedBox(width: 94),
            Expanded(
              flex: 4, // Adjust the flex value to control label width
              child: Text(
                tkey,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 14,
                  fontFamily: 'FuturaMdBT',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );

  Widget textMultilineField(String tlabel, String tkey) => Container(
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
            Expanded(
                flex: 3, // Adjust the flex value to control label width
                child: Text(
                  tlabel,
                  style: const TextStyle(
                    color: Color.fromRGBO(174, 174, 174, 1),
                    fontSize: 14,
                    fontFamily: 'FuturaMdBT',
                    fontWeight: FontWeight.w400,
                  ),
                )),
            //const SizedBox(width: 94),
            Expanded(
              flex: 4, // Adjust the flex value to control label width
              child: Text(
                tkey,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFF565656),
                  fontSize: 14,
                  fontFamily: 'FuturaMdBT',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      );

  Widget defaultPhoto() => ClipOval(
        child: Image.asset(
          'assets/icons/def_user.png',
          width: 60,
          height: 60,
        ),
      );

  @override
  Widget build(BuildContext context) {
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
            color: Color.fromRGBO(9, 56, 131, 1.0),
          ),
        ),
        // actions: <Widget>[
        //   GestureDetector(
        //     onTap: () => {},
        //     child: Image.asset(
        //       'assets/icons/search.png',
        //       alignment: Alignment.center,
        //       width: 24,
        //       height: 24,
        //     ),
        //   ),
        //   SizedBox(width: 8 * (MediaQuery.of(context).size.width / 360)),
        //   GestureDetector(
        //     onTap: () => {},
        //     child: Image.asset(
        //       'assets/icons/bell.png',
        //       alignment: Alignment.center,
        //       width: 24,
        //       height: 24,
        //     ),
        //   ),
        //   SizedBox(width: 8 * (MediaQuery.of(context).size.width / 360)),
        //   Image.asset(
        //     'assets/icons/burger_menu.png',
        //     alignment: Alignment.center,
        //     width: 24,
        //     height: 24,
        //   ),
        //   SizedBox(width: 16 * (MediaQuery.of(context).size.width / 360)),
        // ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                const SizedBox(width: 16),
                GestureDetector(
                    onTap: controller.onTapBackButton,
                    child: const Icon(Icons.arrow_back_ios_new_outlined,
                        size: 20, color: Colors.grey)),
              ]),
              Row(
                children: [
                  // const SizedBox(width: 16),
                  // GestureDetector(
                  //     onTap: controller.onTapBackButton,
                  //     child: const Icon(Icons.arrow_back_ios_new_outlined,
                  //         size: 20, color: Colors.grey)),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: const Text('Profil',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          fontFamily: 'FuturaMdBT',
                          color: Color(0xFF565656),
                        )),
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => buildFotoProfile(context)),
              Center(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 0.2, color: Color.fromRGBO(20, 124, 220, 1)),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: openAssetChooser,
                      child: const Text(
                        'Ubah Foto Profil',
                        style: TextStyle(
                          color: Color.fromRGBO(67, 120, 255, 1),
                          fontSize: 13,
                          fontFamily: 'FuturaMdBT',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 20),
              Obx(() => buildBodyProfile(context)),
              const SizedBox(
                height: 16,
              ),
              Obx(() => buildBodyProfesional(context)),
              const SizedBox(
                height: 16,
              ),
              Obx(() => buildBodyStatus(context)),
              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ],
      )),
    );
  }

  void openAssetChooser() {
    Get.bottomSheet(AssetPickerContent(
        onTapCameraSource: controller.onTapOpenCamera,
        onTapGallerySource: controller.onTapOpenGallery));
  }

  Widget buildFotoProfile(BuildContext context) {
    if ((controller.dataWarga.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.dataWarga.status == Status.success)) {
      if ((controller.dataWarga.data!.isBlank == false)) {
        return Center(
            child: ClipOval(
                child: Obx(
          () => Image.network(controller.dataWarga.data!.namaFile,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              loadingBuilder: (context, widget, progress) =>
                  progress == null ? widget : defaultPhoto(),
              errorBuilder: (context, widget, stackTrace) {
                debugPrint('ERROR IMG: $stackTrace');
                return defaultPhoto();
              }),
        )));
      } else {
        return buildEmptyState();
      }
    } else if ((controller.dataWarga.status == Status.error)) {
      return Center(
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
    } else {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    }
  }

  Widget buildBodyProfile(BuildContext context) {
    if ((controller.dataWarga.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.dataWarga.status == Status.success)) {
      if ((controller.dataWarga.data!.isBlank == false)) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.2,
                              color: Color.fromRGBO(20, 124, 220, 1)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Profil',
                            style: TextStyle(
                              color: Color.fromRGBO(20, 124, 220, 1),
                              fontSize: 14,
                              fontFamily: 'FuturaMdBT',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // const SizedBox(width: 84),
                          GestureDetector(
                            onTap: () {
                              controller.onTapEditProfil();
                            },
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
                                const SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    textField('Nama', controller.dataWarga.data!.nama),
                    //const SizedBox(height: 10),
                    textField('Jenis Kelamin',
                        controller.dataWarga.data!.jenisKelaminNama),
                    textField('TTL',
                        '${controller.dataWarga.data!.tempatLahir}, ${controller.dataWarga.data!.tglLahir.dMYFormatOrDash}'),
                    // textField('Tanggal',
                    //     controller.dataWarga.data!.tglLahir.dMYFormatOrDash),
                    textMultilineField(
                        'Alamat', controller.dataWarga.data!.alamatRumah),
                    textField('Status Rumah',
                        controller.dataWarga.data!.statusRumahNama),
                    textField('Mulai Tinggal',
                        controller.dataWarga.data!.tahunDomisili.toString()),
                    textField('Golongan Darah',
                        controller.dataWarga.data!.golonganDarah),
                    textField(
                        'Daerah Asal', controller.dataWarga.data!.daerahAsal),
                    textField('No KTP', controller.dataWarga.data!.noKtp),
                    textField('Email', controller.dataWarga.data!.email),
                    textField('No Hp', controller.dataWarga.data!.noHp)
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return buildEmptyState();
      }
    } else if ((controller.dataWarga.status == Status.error)) {
      return Center(
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
    } else {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    }
  }

  Widget buildBodyProfesional(BuildContext context) {
    if ((controller.dataWarga.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.dataWarga.status == Status.success)) {
      if ((controller.dataWarga.data!.isBlank == false)) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.2,
                              color: Color.fromRGBO(20, 124, 220, 1)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Profesional',
                            style: TextStyle(
                              color: Color.fromRGBO(20, 124, 220, 1),
                              fontSize: 14,
                              fontFamily: 'FuturaMdBT',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // const SizedBox(width: 84),
                          GestureDetector(
                            onTap: () {
                              controller.onTapEditProfesional();
                            },
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
                                const SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    textField('Pendidikan Terakhir',
                        controller.dataWarga.data!.pendidikanNama),
                    textField(
                        'Pekerjaan', controller.dataWarga.data!.pekerjaanNama),
                    textMultilineField('Nama Perusahaan',
                        controller.dataWarga.data!.namaPerusahaan),
                    textField(
                        'Jenis Usaha', controller.dataWarga.data!.jenisUsaha),
                    textField('Keahlian', controller.dataWarga.data!.keahlian),
                    textField('Penghasilan',
                        controller.dataWarga.data!.penghasilanNama),
                    //const SizedBox(height: 5),
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return buildEmptyState();
      }
    } else if ((controller.dataWarga.status == Status.error)) {
      return Center(
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
    } else {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    }
  }

  Widget buildBodyStatus(BuildContext context) {
    if ((controller.dataWarga.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.dataWarga.status == Status.success)) {
      if ((controller.dataWarga.data!.isBlank == false)) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.2,
                              color: Color.fromRGBO(20, 124, 220, 1)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data Status',
                            style: TextStyle(
                              color: Color.fromRGBO(20, 124, 220, 1),
                              fontSize: 14,
                              fontFamily: 'FuturaMdBT',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // const SizedBox(width: 84),
                          GestureDetector(
                            onTap: () {
                              controller.onTapEditStatus();
                            },
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
                                const SizedBox(width: 5),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    textField('Status Baca Quran',
                        controller.dataWarga.data!.statusBacaAlquranNama),
                    isHajiCheckboxField(),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return buildEmptyState();
      }
    } else if ((controller.dataWarga.status == Status.error)) {
      return Center(
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
    } else {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    }
  }

  Widget buildEmptyState() => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.summarize_outlined,
              size: 56,
              color: Color.fromRGBO(184, 127, 232, 1.0),
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
