import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_controller.dart';

class SignUpPage extends GetView<SignUpController> {
  static const routeName = '/signup';

  SignUpPage({Key? key}) : super(key: key);

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
                    key: controller.signupGlobalKey,
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
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF093883),
                                  fontSize: 20,
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
                          'Nama',
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
                              textAlignVertical: TextAlignVertical.center,
                              validator: controller.isNamaTextFormValid,
                              controller: controller.namaTextEditingController,
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
                              validator: controller.isTeleponTextFormValid,
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
                        Text(
                          'Email',
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
                                  controller.usernameTextEditingController,
                              validator: controller.validateEmail,
                              cursorColor:
                                  const Color.fromRGBO(9, 56, 131, 1.0),
                              decoration: InputDecoration(
                                hintText: 'cth : user@email.com',
                                hintStyle: GoogleFonts.sourceSansPro(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14),
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
                        Text(
                          'Password',
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
                            child: Obx(
                              () => TextFormField(
                                controller:
                                    controller.passwordTextEditingController,
                                validator: controller.isPasswordTextFormValid,
                                obscureText: controller.isPasswordHidden,
                                scrollPadding:
                                    const EdgeInsets.only(bottom: 100),
                                cursorColor:
                                    const Color.fromRGBO(9, 56, 131, 1.0),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      splashRadius: 24,
                                      icon: Icon(
                                          controller.isPasswordHidden
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color.fromRGBO(
                                              9, 56, 131, 1.0)),
                                      onPressed:
                                          controller.onPasswordSuffixTapped),
                                  labelStyle: const TextStyle(
                                    color: Color.fromRGBO(9, 56, 131, 1.0),
                                  ),
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
                                ),
                              ),
                            )),
                        const SizedBox(height: 24),
                        TextButton(
                            onPressed: controller.onTapSignUpButton,
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
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            )),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sudah memiliki akun?',
                              style: GoogleFonts.sourceSansPro(
                                color: const Color(0xFF828282),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => controller.onTapLoginPage(),
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color(0xFF4378FF),
                                  fontSize: 12,
                                  fontFamily: 'Futura MdBT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'OR',
                            style: TextStyle(
                              color: Color(0xFF093883),
                              fontSize: 20,
                              fontFamily: 'Futura MdBT',
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => controller.googleSignIn(),
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFEEEEEE)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/google.png',
                                  width:
                                      24.0, // Set the width of the circular image
                                  height:
                                      24.0, // Set the height of the circular image
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Sign with Google',
                                  style: GoogleFonts.sourceSansPro(
                                    color: const Color(0xFF828282),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
    //                       children: const [SignUpSection()])),
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
