import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Badges {
  static Widget positiveBadgesWidget(String label) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(
            9,
            189,
            155,
            1.0,
          ).withOpacity(
            0.22,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Text(
            label,
            style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color.fromRGBO(
                9,
                189,
                155,
                1.0,
              ),
            ),
          ),
        ));
  }

  static Widget negativeBadgesWidget(String label) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(
          255,
          229,
          236,
          1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Text(
          label,
          style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: const Color.fromRGBO(
              255,
              129,
              166,
              1.0,
            ),
          ),
        ),
      ),
    );
  }

  static Widget warningBadgesWidget(String label) {
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 193, 63, 1.0).withOpacity(
            0.22,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Text(
            label,
            style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color.fromRGBO(
                255,
                193,
                63,
                1.0,
              ),
            ),
          ),
        ));
  }
}
