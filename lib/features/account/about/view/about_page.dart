import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  AboutPage({Key? key}) : super(key: key);

  final Uri url = Uri.parse('https://www.instagram.com/maslam.apps/');

  void launchHyperlink() async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(9, 56, 131, 1.0),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(9, 56, 131, 1.0),
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
          title: Text(
            'About',
            style: GoogleFonts.sourceSansPro(
                color: const Color.fromRGBO(243, 204, 145, 1.0),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: buildBody());
  }

  Widget buildBody() {
    return GestureDetector(
      onTap: launchHyperlink,
      child: Container(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logos/maslam_transparent_logo.png',
                    //color: const Color.fromRGBO(249, 249, 249, 1.0),
                    width: 115,
                    height: 65),
                const SizedBox(height: 16),
                Text(
                  'https://www.instagram.com/maslam.apps/',
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(243, 204, 145, 1.0),
                      fontSize: 12,
                      decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 30),
                Text(
                  'Aplikasi Maslam adalah sebuah platform inovatif yang bertujuan untuk meningkatkan digitalisasi dan pengelolaan masjid.  Dan meningkatkan engagement antara jamaah dan masjid secara digital.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(243, 204, 145, 1.0),
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                const SizedBox(height: 14),
                Text(
                  'Dengan fokus pada pendataan yang terorganisir dan manajemen donasi serta sistem management yang sudah terstruktur dan terarah, aplikasi ini memberikan solusi yang efisien bagi masjid-masjid dalam mengelola dan memperoleh dana.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(243, 204, 145, 1.0),
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
                const SizedBox(height: 14),
                Text(
                  'Maslam juga mengutamakan pelayanan kepada pengguna dengan mencakup daerah-daerah yang lebih dekat terlebih dahulu. Melalui fitur-fitur yang disediakan, aplikasi ini menjadi alat yang dapat mempermudah dan mengoptimalkan pengalaman pengguna dalam berkontribusi dalam pengembangan masjid.',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.sourceSansPro(
                      color: const Color.fromRGBO(243, 204, 145, 1.0),
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
