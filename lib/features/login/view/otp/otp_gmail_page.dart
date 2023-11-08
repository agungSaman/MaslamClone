import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp_gmail_controller.dart';

class OtpGmailPage extends GetView<OtpGmailController> {
  static const routeName = '/otp-gmail';

  OtpGmailPage({Key? key}) : super(key: key);

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  'assets/backgrounds/sign.png',
                  width: double.infinity,
                  height: 290,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: controller.otpGlobalKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 230),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xFFF8E0BD)),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Anda harus memasukan nomor telepon terlebih dahulu',
                                style: TextStyle(
                                  color: Color(0xFF093883),
                                  fontSize: 13,
                                  fontFamily: 'Futura MdBT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          'Nomor Telepon',
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: const Color.fromRGBO(9, 56, 131, 1.0),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                              controller:
                                  controller.teleponTextEditingController,
                              keyboardType: TextInputType.number,
                              cursorColor:
                                  const Color.fromRGBO(9, 56, 131, 1.0),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Color(0xFFF3CC91)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Color(0xFFF3CC91)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        // Text(
                        //   'Password',
                        //   style: GoogleFonts.sourceSansPro(
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 16,
                        //     color: const Color.fromRGBO(9, 56, 131, 1.0),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // SizedBox(
                        //     height: 50,
                        //     child: Obx(
                        //       () => TextFormField(
                        //         controller:
                        //             controller.passwordTextEditingController,
                        //         validator: controller.isPasswordTextFormValid,
                        //         obscureText: controller.isPasswordHidden,
                        //         scrollPadding:
                        //             const EdgeInsets.only(bottom: 100),
                        //         cursorColor:
                        //             const Color.fromRGBO(9, 56, 131, 1.0),
                        //         decoration: InputDecoration(
                        //           suffixIcon: IconButton(
                        //               splashRadius: 24,
                        //               icon: Icon(
                        //                   controller.isPasswordHidden
                        //                       ? Icons.visibility
                        //                       : Icons.visibility_off,
                        //                   color: const Color.fromRGBO(
                        //                       9, 56, 131, 1.0)),
                        //               onPressed:
                        //                   controller.onPasswordSuffixTapped),
                        //           labelStyle: const TextStyle(
                        //             color: Color.fromRGBO(9, 56, 131, 1.0),
                        //           ),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 2, color: Color(0xFFF3CC91)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 3, color: Color(0xFFF3CC91)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                        const SizedBox(height: 24),
                        TextButton(
                            onPressed: controller.onTapOtpButton,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(9, 56, 131, 1.0)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(top: 12),
                              height: 50,
                              width: double.infinity,
                              child: Text(
                                'Sign Up using Gmail',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            )),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
          Visibility(
              visible: controller.isLoading, child: bigLoadingIndicator())
        ]),
      ),
    );

    // Obx(() => Container(
    //       color: controller.isLoading
    //           ? loadingBackgroundColor
    //           : const Color.fromRGBO(7, 56, 130, 1.0),
    //       child: SafeArea(
    //           bottom: false,
    //           child: Scaffold(
    //             resizeToAvoidBottomInset: false,
    //             body: Stack(children: [
    //               SizedBox(
    //                   height: double.infinity,
    //                   child: Column(children: [
    //                     // const SizedBox(height: 25),
    //                     Stack(
    //                       children: [
    //                         Image.asset(
    //                           'assets/backgrounds/sign.png',
    //                           width: double.infinity,
    //                           height: 290,
    //                           fit: BoxFit.cover,
    //                         ),
    //                       ],
    //                     ),
    //                     const Spacer(),
    //                   ])),
    //               Positioned.fill(
    //                   child: PageView(
    //                       controller: controller.pageViewController,
    //                       physics: const NeverScrollableScrollPhysics(),
    //                       children: const [OtpSection()])),
    //               Positioned.fill(
    //                   child: Visibility(
    //                       visible: controller.isLoading,
    //                       child: bigLoadingIndicator()))
    //             ]),
    //           )),
    //     ));
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple)),
        ),
      )));
}
