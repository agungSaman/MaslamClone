import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  static const routeName = '/change-password';

  final loadingBackgroundColor = Colors.grey.withOpacity(0.75);

  ChangePasswordPage({Key? key}) : super(key: key);

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
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 250, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: controller.onTapBackButton,
                              child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 20,
                                  color: Colors.grey)),
                          const SizedBox(
                            height: 8,
                          ),
                          const Expanded(
                            // width: double.infinity,
                            // alignment: Alignment.center,
                            child: Text('Ubah Password',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Futura MdBT',
                                  fontSize: 18,
                                  color: Color(0xFF093883),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Pastikan password baru Anda menggunakan ',
                              style: TextStyle(
                                color: Color(0xFF325997),
                                fontSize: 14,
                                fontFamily: 'Futura Md BT',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'huruf kapital',
                              style: TextStyle(
                                color: Color(0xFFC8A166),
                                fontSize: 14,
                                fontFamily: 'Futura Md BT',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' dan ',
                              style: TextStyle(
                                color: Color(0xFF325997),
                                fontSize: 14,
                                fontFamily: 'Futura Md BT',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'angka',
                              style: TextStyle(
                                color: Color(0xFFC8A166),
                                fontSize: 14,
                                fontFamily: 'Futura Md BT',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' (min. 8 karakter)',
                              style: TextStyle(
                                color: Color(0xFF325997),
                                fontSize: 14,
                                fontFamily: 'Futura Md BT',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: controller.changePasswordGlobalKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Current Password',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(() => SizedBox(
                                    height: 45,
                                    child: TextFormField(
                                      controller: controller
                                          .currentPasswordTextEditingController,
                                      validator: controller
                                          .isCurrentPasswordTextFormValid,
                                      obscureText:
                                          controller.isCurrentPasswordHidden,
                                      scrollPadding:
                                          const EdgeInsets.only(bottom: 100),
                                      cursorColor:
                                          const Color.fromRGBO(9, 56, 131, 1.0),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            splashRadius: 24,
                                            icon: Icon(
                                                controller
                                                        .isCurrentPasswordHidden
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: const Color.fromRGBO(
                                                    9, 56, 131, 1.0)),
                                            onPressed: controller
                                                .onTapCurrentPasswordSuffix),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xFFF3CC91)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3,
                                              color: Color(0xFFF3CC91)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'New Password',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller: controller
                                      .newPasswordTextEditingController,
                                  validator:
                                      controller.isNewPasswordTextFormValid,
                                  obscureText: controller.isNewPasswordHidden,
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 100),
                                  cursorColor:
                                      const Color.fromRGBO(9, 56, 131, 1.0),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(
                                            controller.isNewPasswordHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: const Color.fromRGBO(
                                                9, 56, 131, 1.0)),
                                        onPressed:
                                            controller.onTapNewPasswordSuffix),
                                    hintText: 'min. 8 characters',
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
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Repeat Password',
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(9, 56, 131, 1.0),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(
                                () => TextFormField(
                                  controller: controller
                                      .confirmNewPasswordTextEditingController,
                                  validator: controller
                                      .isConfirmNewPasswordTextFormValid,
                                  obscureText:
                                      controller.isConfirmNewPasswordHidden,
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 100),
                                  cursorColor:
                                      const Color.fromRGBO(9, 56, 131, 1.0),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                        splashRadius: 24,
                                        icon: Icon(
                                            controller
                                                    .isConfirmNewPasswordHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: const Color.fromRGBO(
                                                9, 56, 131, 1.0)),
                                        onPressed: controller
                                            .onTapConfirmNewPasswordSuffix),
                                    hintText: 'min. 8 characters',
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
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                    onPressed: controller.onTapChangePassword,
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromRGBO(
                                                  9, 56, 131, 1.0)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      )),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 55, vertical: 4),
                                      child: Text(
                                        'Ubah Password',
                                        style: GoogleFonts.sourceSansPro(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white),
                                      ),
                                    )),
                              ),
                            ],
                          ))
                    ],
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
