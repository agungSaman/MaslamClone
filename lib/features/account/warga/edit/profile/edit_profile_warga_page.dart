import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../commons/result.dart';
import '../../../../../../utils/date_formatter.dart';
import '../../../../shared/gender/data/models/gender.dart';
import '../../../../shared/status_rumah/data/models/status_rumah.dart';
import 'edit_profile_warga_controller.dart';

class EditProfileWargaPage extends GetView<EditProfileWargaController> {
  static const routeName = '/edit-profile-warga';

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  EditProfileWargaPage({Key? key}) : super(key: key);

  Widget genderDropdownField() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Jenis Kelamin',
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
                  value: controller.genderList.data!
                      .firstWhere((item) =>
                          item.jkId == controller.tempWargaData['jkId'])
                      .jkId,
                  items: controller.genderList.data!
                      .map<DropdownMenuItem<String>>((Gender gender) {
                    return DropdownMenuItem<String>(
                      value: gender.jkId,
                      child: Text(
                        gender.nama,
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      controller.onChangeWargaStringField('jkId', value!),
                ),
              )),
        ),
      ]);

  Widget statusRumahDropdownField() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Status Rumah',
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
                  value: controller.statusRumahList.data!
                      .firstWhere((item) =>
                          item.statusRumahId ==
                          controller.tempWargaData['statusRumahId'])
                      .statusRumahId,
                  items: controller.statusRumahList.data!
                      .map<DropdownMenuItem<String>>((StatusRumah statusRumah) {
                    return DropdownMenuItem<String>(
                      value: statusRumah.statusRumahId,
                      child: Text(
                        statusRumah.nama,
                        style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(174, 174, 174, 1),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => controller.onChangeWargaStringField(
                      'statusRumahId', value!),
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

  Widget textNumberField(
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
        SizedBox(
          height: 40,
          child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              controller: tcontroller,
              scrollPadding: const EdgeInsets.only(bottom: 100),
              cursorColor: const Color.fromRGBO(9, 56, 131, 1.0),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
      ]);

  Widget dateField(Function(DateTime?) onPickDate, BuildContext context,
          String title, RxString observable) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
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
                border: Border.all(
                    color: const Color.fromRGBO(241, 238, 238, 1.0))),
            height: 40,
            width: double.infinity,
            child: GestureDetector(
                onTap: () async {
                  var pickedDate = await showDatePicker(
                      context: context,
                      builder: (context, child) => Theme(
                          data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                  primary: Color.fromRGBO(9, 56, 131, 1.0))),
                          child: child!),
                      initialDate: controller.birthDate,
                      currentDate: observable.value.mMddYYYYFormat,
                      firstDate: DateTime(1, 1, 1900),
                      lastDate: DateTime.now());
                  onPickDate(pickedDate);
                },
                child: Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: Text(
                          observable.value,
                          style: GoogleFonts.sourceSansPro(
                            color: const Color.fromRGBO(174, 174, 174, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                    const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Color.fromRGBO(174, 174, 174, 1),
                        ))
                  ],
                )))
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
                    buildBodyProfile(context),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      child: TextButton(
                          onPressed: controller.onTapSaveProfil,
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

  Widget buildBodyProfile(BuildContext context) {
    if ((controller.genderList.status == Status.loading) ||
        (controller.statusRumahList.status == Status.loading)) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.genderList.status == Status.success) &&
        (controller.statusRumahList.status == Status.success)) {
      if ((controller.genderList.data!.isNotEmpty) &&
          (controller.statusRumahList.data!.isNotEmpty)) {
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
                    key: controller.formGlobalKeyProfil,
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
                                'Data Profil',
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
                        const SizedBox(height: 12),
                        textField(controller.namaTextEditingController, 'Nama',
                            'nama'),
                        const SizedBox(height: 10),
                        genderDropdownField(),
                        const SizedBox(height: 10),
                        textField(controller.birthplaceTextEditingController,
                            'Tempat Lahir', 'tempatLahir'),
                        const SizedBox(height: 10),
                        dateField(
                            controller.onBirthDate,
                            context,
                            'Tanggal Lahir',
                            controller.birthdateTextEditingController),
                        const SizedBox(height: 10),
                        textMultilineField(
                            controller.alamatTextEditingController,
                            'Alamat',
                            'alamat'),
                        const SizedBox(height: 10),
                        statusRumahDropdownField(),
                        const SizedBox(height: 10),
                        textNumberField(
                            controller.tinggalSejakTextEditingController,
                            'Mulai Tinggal',
                            'tinggalSejak'),
                        const SizedBox(height: 10),
                        textField(controller.goldarTextEditingController,
                            'Golongan Darah', 'goldar'),
                        const SizedBox(height: 10),
                        textField(controller.daerahAsalTextEditingController,
                            'Daerah Asal', 'daerahAsal'),
                        const SizedBox(height: 10),
                        textNumberField(controller.noKtpTextEditingController,
                            'No Ktp', 'noKtp'),
                      ],
                    ))
              ],
            ),
          ),
        );
      } else {
        return buildEmptyState();
      }
    } else if ((controller.genderList.status == Status.error) ||
        (controller.statusRumahList.status == Status.error)) {
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
