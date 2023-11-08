import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectableChip extends StatelessWidget {
  final bool isSelected;
  final String label;

  const SelectableChip(
      {Key? key, required this.isSelected, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromRGBO(201, 239, 255, 1.0)
              : Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
              color: isSelected
                  ? const Color.fromRGBO(0, 178, 255, 1.0)
                  : const Color.fromRGBO(154, 154, 154, 1.0))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(
          label,
          style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: isSelected
                  ? const Color.fromRGBO(0, 178, 255, 1.0)
                  : const Color.fromRGBO(154, 154, 154, 1.0)),
        ),
      ),
    );
  }
}

class SelectableChipShimmer extends StatelessWidget {
  const SelectableChipShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
  }
}
