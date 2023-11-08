import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuGridSection extends StatelessWidget {
  final String title;
  final List<Widget> menuItems;
  final double? spacing;

  const MenuGridSection({
    Key? key,
    required this.title,
    required this.menuItems,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color.fromRGBO(136, 134, 134, 1.0))),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                    spacing: spacing ?? 18,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 8,
                    children: menuItems),
              )
            ])));
  }
}
