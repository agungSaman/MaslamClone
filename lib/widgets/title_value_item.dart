import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleValueItem extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  const TitleValueItem(
      {Key? key,
      required this.title,
      required this.value,
      this.titleStyle,
      this.valueStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              GoogleFonts.sourceSansPro(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Align(
              alignment: Alignment.topRight,
              child: Text(value,
                  textAlign: TextAlign.end,
                  style: valueStyle ??
                      GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black))),
        )
      ],
    );
  }
}
