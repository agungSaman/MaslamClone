import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickableItemWidget extends StatelessWidget {
  final String value;
  final VoidCallback onTapItem;

  const PickableItemWidget(
      {Key? key, required this.value, required this.onTapItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            value,
            style: GoogleFonts.sourceSansPro(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
