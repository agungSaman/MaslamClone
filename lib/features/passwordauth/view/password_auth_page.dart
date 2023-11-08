import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'password_auth_controller.dart';

class PasswordAuthPage extends GetView<PasswordAuthController> {
  static const routeName = '/password-auth';

  const PasswordAuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(157, 125, 228, 1.0),
      body: Stack(
        children: [
          Positioned(
            left: 18,
            top: 48,
            child: IconButton(
                onPressed: controller.onTapBackButton,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.white,
                )),
          ),
          Positioned.fill(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(19),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(134, 103, 202, 1.0),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.lock,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Text(
                      'Please enter your password to continue',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Obx(
                      () => TextField(
                        controller: controller.passwordTextEditingController,
                        obscureText: controller.isPasswordHidden,
                        scrollPadding: const EdgeInsets.only(bottom: 100),
                        cursorColor: Colors.white,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              splashRadius: 24,
                              icon: Icon(
                                  controller.isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white),
                              onPressed: controller.onPasswordSuffixTapped),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: controller.onTapConfirmButton,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 8),
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: const Color.fromRGBO(9, 56, 131, 1.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
