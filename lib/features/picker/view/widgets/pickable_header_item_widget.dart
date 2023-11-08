import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickableHeaderItemWidget extends StatelessWidget {
  final String title;

  const PickableHeaderItemWidget({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      color: const Color.fromRGBO(234, 234, 234, 1.0),
      child: Text(
        title,
        style: GoogleFonts.sourceSansPro(
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(163, 163, 163, 1.0)),
      ),
    );
  }
}
