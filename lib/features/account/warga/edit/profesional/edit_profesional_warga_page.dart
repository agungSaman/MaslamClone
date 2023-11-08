import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../commons/result.dart';
import '../../../../shared/pekerjaan/data/models/pekerjaan.dart';
import '../../../../shared/pendidikan/data/models/pendidikan.dart';
import '../../../../shared/penghasilan/data/models/penghasilan.dart';
import 'edit_profesional_warga_controller.dart';

class EditProfesionalWargaPage extends GetView<EditProfesionalWargaController> {
  static const routeName = '/edit-profesional-warga';

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  EditProfesionalWargaPage({Key? key}) : super(key: key);

  Widget pendidikanDropdownField() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Pendidikan',
          style: GoogleFonts.sourceSansPro(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
          height: 40,
          width: double.infinity,
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: Color.fromRGBO(174, 174, 174, 1),
                  ),
                  value: controller.pendidikanList.data!
                      .firstWhere((item) =>
                          item.pendidikanId ==
                          controller.tempWargaData['pendidikanId'])
                      .pendidikanId,
                  items: controller.pendidikanList.data!
                      .map<DropdownMenuItem<String>>((Pendidikan pendidikan) {
                    return DropdownMenuItem<String>(
                      value: pendidikan.pendidikanId,
                      child: Text(
                        pendidikan.nama,
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => controller.onChangeWargaStringField(
                      'pendidikanId', value!),
                ),
              )),
        )
      ]);

  Widget pekerjaanDropdownField() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Pekerjaan',
          style: GoogleFonts.sourceSansPro(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
          height: 40,
          width: double.infinity,
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: Color.fromRGBO(174, 174, 174, 1),
                  ),
                  value: controller.pekerjaanList.data!
                      .firstWhere((item) =>
                          item.pekerjaanId ==
                          controller.tempWargaData['pekerjaanId'])
                      .pekerjaanId,
                  items: controller.pekerjaanList.data!
                      .map<DropdownMenuItem<String>>((Pekerjaan pekerjaan) {
                    return DropdownMenuItem<String>(
                      value: pekerjaan.pekerjaanId,
                      child: Text(
                        pekerjaan.nama,
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => controller.onChangeWargaStringField(
                      'pekerjaanId', value!),
                ),
              )),
        )
      ]);

  Widget penghasilanDropdownField() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Penghasilan',
          style: GoogleFonts.sourceSansPro(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
          height: 40,
          width: double.infinity,
          child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: const Icon(
                    Icons.expand_more_outlined,
                    color: Color.fromRGBO(174, 174, 174, 1),
                  ),
                  value: controller.penghasilanList.data!
                      .firstWhere((item) =>
                          item.penghasilanId ==
                          controller.tempWargaData['penghasilanId'])
                      .penghasilanId,
                  items: controller.penghasilanList.data!
                      .map<DropdownMenuItem<String>>((Penghasilan penghasilan) {
                    return DropdownMenuItem<String>(
                      value: penghasilan.penghasilanId,
                      child: Text(
                        penghasilan.nama,
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => controller.onChangeWargaStringField(
                      'penghasilanId', value!),
                ),
              )),
        )
      ]);

  Widget textField(
          TextEditingController tcontroller, String tlabel, String tkey) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tlabel,
            style: GoogleFonts.sourceSansPro(
              color: const Color.fromRGBO(0, 0, 0, 1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 40,
            child: TextFormField(
                textAlignVertical: TextAlignVertical.top,
                controller: tcontroller,
                cursorColor: const Color.fromRGBO(9, 56, 131, 1.0),
                style: GoogleFonts.sourceSansPro(
                  color: const Color.fromRGBO(174, 174, 174, 1),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(174, 174, 174, 0.3),
                        width: 1,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(174, 174, 174, 0.3),
                        width: 1,
                      )),
                ),
                onChanged: (value) =>
                    controller.onChangeWargaStringField(tkey, value)),
          )
        ],
      );

  Widget textMultilineField(
          TextEditingController tcontroller, String tlabel, String tkey) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          tlabel,
          style: GoogleFonts.sourceSansPro(
            color: const Color.fromRGBO(0, 0, 0, 1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
            controller: tcontroller,
            scrollPadding: const EdgeInsets.only(bottom: 100),
            textAlignVertical: TextAlignVertical.top,
            cursorColor: const Color.fromRGBO(9, 56, 131, 1.0),
            maxLines: 3,
            style: GoogleFonts.sourceSansPro(
              color: const Color.fromRGBO(174, 174, 174, 1),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(174, 174, 174, 0.3),
                    width: 1,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(174, 174, 174, 0.3),
                    width: 1,
                  )),
            ),
            onChanged: (value) =>
                controller.onChangeWargaStringField(tkey, value)),
      ]);

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
      body: Obx(() => Stack(children: [
            SingleChildScrollView(
                child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: controller.onTapBackButton,
                              child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 20,
                                  color: Colors.grey)),
                        ),
                        const Expanded(flex: 3, child: SizedBox()),
                        const Expanded(
                            flex: 5,
                            child: Text('Profil',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'FuturaMdBT',
                                  color: Color(0xFF565656),
                                )))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildBodyProfesional(context),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: controller.onTapSaveProfesional,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(9, 56, 131, 1.0)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55, vertical: 4),
                            child: Text(
                              'Simpan',
                              style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ],
            )),
            Visibility(
                visible: controller.isLoading, child: bigLoadingIndicator())
          ])),
    );
  }

  Widget buildBodyProfesional(BuildContext context) {
    if ((controller.pendidikanList.status == Status.loading) ||
        (controller.pekerjaanList.status == Status.loading) ||
        (controller.penghasilanList.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.pendidikanList.status == Status.success) &&
        (controller.pekerjaanList.status == Status.success) &&
        (controller.penghasilanList.status == Status.success)) {
      if ((controller.pendidikanList.data!.isNotEmpty) &&
          (controller.pekerjaanList.data!.isNotEmpty) &&
          (controller.penghasilanList.data!.isNotEmpty)) {
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
                Form(
                    key: controller.formGlobalKeyProfesional,
                    child: Column(
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
                            children: const [
                              Text(
                                'Data Profesional',
                                style: TextStyle(
                                  color: Color.fromRGBO(20, 124, 220, 1),
                                  fontSize: 14,
                                  fontFamily: 'FuturaMdBT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              // const SizedBox(width: 84),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        pendidikanDropdownField(),
                        const SizedBox(height: 10),
                        pekerjaanDropdownField(),
                        const SizedBox(height: 10),
                        textMultilineField(
                            controller.namaUsahaTextEditingController,
                            'Nama Perusahaan',
                            'namaPerusahaan'),
                        const SizedBox(height: 10),
                        textField(controller.jenisUsahaTextEditingController,
                            'Jenis Usaha', 'jenisUsaha'),
                        const SizedBox(height: 10),
                        textField(controller.keahlianTextEditingController,
                            'Keahlian', 'keahlian'),
                        const SizedBox(height: 10),
                        penghasilanDropdownField(),
                        //const SizedBox(height: 5),
                      ],
                    ))
              ],
            ),
          ),
        );
      } else {
        return buildEmptyState();
      }
    } else if ((controller.pendidikanList.status == Status.error) ||
        (controller.pekerjaanList.status == Status.error) ||
        (controller.penghasilanList.status == Status.error)) {
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
