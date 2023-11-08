import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'logout_controller.dart';

class LogoutPage extends GetView<LogoutController> {
  static const routeName = '/logout-confirm';

  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.exit_to_app,
                      size: 45,
                      color: Color.fromRGBO(7, 56, 130, 1.0),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Logout',
                      style: GoogleFonts.sourceSansPro(
                          color: const Color.fromRGBO(7, 56, 130, 1.0),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Do you want to logout?',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: controller.onTapNoButton,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromRGBO(9, 56, 131, 1.0)),
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 55, vertical: 8),
                          child: Text(
                            'No',
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color:
                                    const Color.fromRGBO(9, 56, 131, 1.0)),
                          ),
                        ))),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                      onPressed: controller.onTapYesButton,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(9, 56, 131, 1.0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 55, vertical: 8),
                        child: Text(
                          'Yes',
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      )),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
