import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasjidListWidget extends StatelessWidget {
  final String namaMasjid;
  final String namaKelurahan;
  final String namaKecamatan;
  final String namaKota;
  final String waktuTempuh;
  final String jarak;
  final String urlImage;

  const MasjidListWidget(
      {Key? key,
      required this.namaMasjid,
      required this.namaKelurahan,
      required this.namaKecamatan,
      required this.namaKota,
      required this.waktuTempuh,
      required this.jarak,
      required this.urlImage})
      : super(key: key);

  Widget defaultPhoto() => Container(
        padding: const EdgeInsets.fromLTRB(50, 20, 35, 20),
        child: Image.asset(
          'assets/logos/maslam_transparent_logo.png',
          width: 60,
          height: 30,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
      child: Wrap(
          spacing: 8,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 9,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                    child: Image.network(urlImage,
                        width: 150,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, widget, progress) =>
                            progress == null ? widget : defaultPhoto(),
                        errorBuilder: (context, widget, stackTrace) {
                          debugPrint('ERROR IMG: $stackTrace');
                          return defaultPhoto();
                        }),
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            namaMasjid,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey[600]),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/home_location.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              '$namaKelurahan, $namaKota',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/home_clock.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              waktuTempuh,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/home_distance.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              jarak,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
