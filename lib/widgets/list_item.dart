import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  final Color horizontalLineColor;
  final VoidCallback onTap;
  final String label;

  const ListItem(
      {required this.horizontalLineColor,
      Key? key,
      required this.onTap,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 51,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(244, 244, 244, 1.0),
              spreadRadius: 3,
              blurRadius: 6,
              offset: Offset(5, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            horizontalLine(),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.sourceSansPro(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: const Color.fromRGBO(136, 134, 134, 1.0)),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            )
          ]),
        ),
      ),
    );
  }

  Widget horizontalLine() => Container(
        decoration: BoxDecoration(
          color: horizontalLineColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        width: 4,
        height: double.infinity,
      );
}
