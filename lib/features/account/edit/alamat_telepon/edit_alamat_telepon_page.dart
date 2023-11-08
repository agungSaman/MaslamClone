import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../commons/result.dart';
import 'edit_alamat_telepon_controller.dart';

class EditAlamatTeleponPage extends GetView<EditAlamatTeleponController> {
  static const routeName = '/edit-alamat-telepon';

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  EditAlamatTeleponPage({Key? key}) : super(key: key);

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
                    controller.onChangeStringField(tkey, value)),
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
            onChanged: (value) => controller.onChangeStringField(tkey, value)),
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
                  controller.onChangeStringField(tkey, value)),
        )
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
                    Row(children: [
                      const SizedBox(width: 16),
                      GestureDetector(
                          onTap: controller.onTapBackButton,
                          child: const Icon(Icons.arrow_back_ios_new_outlined,
                              size: 20, color: Colors.grey)),
                    ]),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: const Text('Lengkapi data Telepon dan Alamat',
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
                    const SizedBox(height: 20),
                    buildBodyProfile(context),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: controller.onTapBackButton,
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(1),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(241, 241, 241, 1)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                )),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 55),
                                child: Text(
                                  'Batal',
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          9, 56, 131, 1.0)),
                                ),
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TextButton(
                                onPressed: controller.onTapSave,
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(1),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(9, 56, 131, 1.0)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                                ),
                                child: Text(
                                  'Ajukan Jamaah',
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white),
                                )),
                          )
                        ],
                      ),
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
    if (controller.dataWarga.status == Status.loading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromRGBO(9, 56, 131, 1.0),
      ));
    } else if ((controller.dataWarga.status == Status.success)) {
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
                  key: controller.formGlobalKeyAlamatTelepon,
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
                              'Data User',
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
                      textNumberField(controller.noHpTextEditingController,
                          'No Hp', 'noHp'),
                      const SizedBox(height: 10),
                      textMultilineField(controller.alamatTextEditingController,
                          'Alamat', 'alamat'),
                    ],
                  ))
            ],
          ),
        ),
      );
    } else if (controller.dataWarga.status == Status.error) {
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
