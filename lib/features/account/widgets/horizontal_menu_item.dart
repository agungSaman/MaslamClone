import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HorizontalMenuItem extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const HorizontalMenuItem(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 18),
            Text(title, style: GoogleFonts.sourceSansPro(color: Colors.black))
          ],
        ),
      ),
    );
  }
}
