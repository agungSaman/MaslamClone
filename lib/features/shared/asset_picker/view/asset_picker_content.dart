import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetPickerContent extends StatelessWidget {
  final VoidCallback onTapCameraSource;
  final VoidCallback onTapGallerySource;

  const AssetPickerContent(
      {Key? key,
      required this.onTapCameraSource,
      required this.onTapGallerySource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, Get.mediaQuery.padding.bottom + 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select image source',
              style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 14),
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: onTapCameraSource,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Camera',
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 12),
                      )
                    ],
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: onTapGallerySource,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.collections,
                        size: 32,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Gallery',
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 12),
                      )
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
