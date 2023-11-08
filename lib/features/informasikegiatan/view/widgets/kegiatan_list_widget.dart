import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KegiatanListWidget extends StatelessWidget {
  final String namaKegiatan;
  final String namaMasjid;
  final String namaUstadz;
  final String tanggalAcara;
  final bool isBayar;
  final String tiket;
  final String urlImage;

  const KegiatanListWidget(
      {Key? key,
      required this.namaKegiatan,
      required this.namaMasjid,
      required this.namaUstadz,
      required this.tanggalAcara,
      required this.isBayar,
      required this.tiket,
      required this.urlImage})
      : super(key: key);

  Widget defaultPhoto() => Container(
        width: 130,
        height: 130,
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
                        width: 130,
                        height: 130,
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
                            namaKegiatan,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey[600]),
                            softWrap: false,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/masjid.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              namaMasjid,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ))
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/ustadz.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              namaUstadz,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/calendar.png',
                              width:
                                  20.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              tanggalAcara,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/ticket.png',
                              width:
                                  25.0, // Set the width of the circular image
                              height:
                                  20.0, // Set the height of the circular image
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Text(
                              isBayar ? tiket : 'Gratis untuk Umum',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: const Color.fromRGBO(99, 213, 152, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
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
