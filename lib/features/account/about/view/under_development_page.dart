import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderDevelopmentPage extends StatelessWidget {
  static const routeName = '/under-development';

  const UnderDevelopmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(9, 56, 131, 1.0),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Color.fromRGBO(243, 204, 145, 1.0),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // This will navigate back to the previous page.
            },
          ),
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
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(height: 16),
              // Image.asset('assets/logos/maslam_transparent_logo.png',
              //     //color: const Color.fromRGBO(249, 249, 249, 1.0),
              //     width: 46,
              //     height: 26),
              // const SizedBox(height: 30),
              const Icon(
                Icons.construction_outlined,
                size: 80,
                color: Color.fromRGBO(243, 204, 145, 1.0),
              ),
              const SizedBox(height: 14),
              Text(
                'This page is Under Development',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSansPro(
                    color: const Color.fromRGBO(243, 204, 145, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 28),
              ),
              const SizedBox(height: 14),
            ],
          )),
    );
  }
}
