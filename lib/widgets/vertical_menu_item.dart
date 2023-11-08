import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalMenuItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final double width;

  const VerticalMenuItem(
      {this.width = 65, required this.icon, Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          icon,
          const SizedBox(
            height: 8,
          ),
          Text(label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(136, 134, 134, 1.0)))
        ],
      ),
    );
  }
}

class VerticalMenuItemShimmer extends StatelessWidget {
  const VerticalMenuItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 65,
            height: 12,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
