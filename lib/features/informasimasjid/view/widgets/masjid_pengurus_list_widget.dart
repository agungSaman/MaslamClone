import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasjidPengurusListWidget extends StatelessWidget {
  final double scale;
  final String nama;
  final String jabatan;

  const MasjidPengurusListWidget(
      {Key? key,
      required this.scale,
      required this.nama,
      required this.jabatan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 288 * scale,
      height: 31,
      padding: const EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.fromLTRB(20 * scale, 0, 8 * scale, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              jabatan,
              style: GoogleFonts.sourceSansPro(
                color: const Color.fromRGBO(174, 174, 174, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // const SizedBox(width: 84),
          Expanded(
              child: Text(
            nama,
            textAlign: TextAlign.left,
            style: GoogleFonts.sourceSansPro(
              color: const Color.fromRGBO(174, 174, 174, 1),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
}
