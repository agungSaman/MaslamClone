import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiState {
  static Widget emptyStateWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.list_alt,
            size: 56,
            color: Color.fromRGBO(7, 56, 130, 1.0),
          ),
          const SizedBox(height: 12),
          Text(
            'No data found',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.sourceSansPro(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ]),
      ),
    );
  }

  static Widget errorStateWidget() {
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
            style:
                GoogleFonts.sourceSansPro(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ]),
      ),
    );
  }
}
