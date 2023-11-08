import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColoredChip extends StatelessWidget {
  final String label;
  final Color primaryColor;
  final Color secondaryColor;
  final Color? labelColor;

  const ColoredChip(
      {Key? key,
      required this.label,
      required this.primaryColor,
      required this.secondaryColor,
      this.labelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w500,
              color: labelColor ?? primaryColor,
              fontSize: 12),
        ),
      ),
    );
  }
}
