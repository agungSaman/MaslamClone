import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasjidListWidget extends StatelessWidget {
  final String namaMasjid;
  final String alamat;
  final String namaKelurahan;
  final String namaKecamatan;
  final String namaKota;
  final String aksi;
  final String ketAksi;
  final bool isJamaah;
  final bool isBookmark;
  final bool isLike;
  final String urlImage;

  const MasjidListWidget(
      {Key? key,
      required this.namaMasjid,
      required this.alamat,
      required this.namaKelurahan,
      required this.namaKecamatan,
      required this.namaKota,
      required this.aksi,
      required this.ketAksi,
      required this.isJamaah,
      required this.isBookmark,
      required this.isLike,
      required this.urlImage})
      : super(key: key);

  Color get chipColor {
    switch (aksi) {
      case 'R':
        return const Color.fromRGBO(255, 193, 63, 1.0).withOpacity(0.22);
      case 'A':
        return const Color.fromRGBO(9, 189, 155, 1.0).withOpacity(0.22);
      case 'X':
        return const Color.fromRGBO(255, 129, 166, 1.0).withOpacity(0.22);
      default:
        return const Color.fromRGBO(134, 134, 134, 1.0).withOpacity(0.22);
    }
  }

  Color get chipTextColor {
    switch (aksi) {
      case 'R':
        return const Color.fromRGBO(255, 193, 63, 1.0);
      case 'A':
        return const Color.fromRGBO(9, 189, 155, 1.0);
      case 'X':
        return const Color.fromRGBO(255, 129, 166, 1.0);
      default:
        return const Color.fromRGBO(134, 134, 134, 1.0);
    }
  }

  String get labelText {
    switch (aksi) {
      case 'R':
        return 'Dalam Review';
      case 'A':
        return 'Jamaah';
      case 'X':
        return 'Ditolak';
      default:
        return 'Belum sebagai Jamaah';
    }
  }

  Widget statusChip() => Container(
      decoration: BoxDecoration(
          color: chipColor,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Text(labelText,
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: chipTextColor)),
      ));

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
            border:
                Border.all(color: const Color.fromRGBO(241, 238, 238, 1.0))),
        child:
            // Wrap(
            //     spacing: 8,
            //     alignment: WrapAlignment.start,
            //     crossAxisAlignment: WrapCrossAlignment.start,
            //     runSpacing: 9,
            //     children: [

            Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                              child: Image.network(urlImage,
                                  width: 150,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, widget, progress) =>
                                      progress == null
                                          ? widget
                                          : defaultPhoto(),
                                  errorBuilder: (context, widget, stackTrace) {
                                    debugPrint('ERROR IMG: $stackTrace');
                                    return defaultPhoto();
                                  }),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                isJamaah
                                    ? Image.asset('assets/icons/jamaah.png',
                                        width:
                                            20.0, // Set the width of the circular image
                                        height: 20.0)
                                    : Image.asset('assets/icons/jamaah.png',
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.grey),
                                const SizedBox(width: 5),
                                isBookmark
                                    ? Image.asset(
                                        'assets/icons/bookmark.png',
                                        width: 20.0,
                                        height: 20.0,
                                      )
                                    : Image.asset('assets/icons/bookmark.png',
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.grey),
                                const SizedBox(width: 5),
                                isLike
                                    ? Image.asset(
                                        'assets/icons/heart.png',
                                        width: 20.0,
                                        height: 20.0,
                                      )
                                    : Image.asset('assets/icons/heart.png',
                                        width: 20.0,
                                        height: 20.0,
                                        color: Colors.grey),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 17),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  namaMasjid,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.grey[600]),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '$alamat, $namaKelurahan, $namaKecamatan, $namaKota',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.sourceSansPro(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 2,
                        // ),
                        // Column(
                        //   children: [
                        //     SizedBox(
                        //       height: 60,
                        //     ),
                        //     Icon(
                        //       Icons.arrow_forward_ios_rounded,
                        //       size: 24,
                        //       color: Color.fromRGBO(130, 130, 130, 1.0),
                        //     ),
                        //   ],
                        // )

                        // Container(
                        //   // color: Colors.amber,
                        //   alignment: Alignment.centerRight,
                        //   child:
                        // )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Status',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color.fromRGBO(9, 56, 131, 1),
                          ),
                        ),
                        const SizedBox(width: 130),
                        statusChip(),
                        // ColoredChip(
                        //     label: 'Menunggu Konfirmasi',
                        //     primaryColor:
                        //         const Color.fromRGBO(160, 125, 228, 1.0),
                        //     secondaryColor:
                        //         const Color.fromRGBO(160, 125, 228, 1.0)
                        //             .withOpacity(0.22)),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: 120,
                        //   padding: EdgeInsets.symmetric(horizontal: 5),
                        //   color: Colors.amberAccent,
                        //   child: Text(
                        //     "Menunggu",
                        //     textAlign: TextAlign.end,
                        //     style: GoogleFonts.sourceSansPro(
                        //         fontWeight: FontWeight.w400,
                        //         fontSize: 13,
                        //         color: Colors.grey[600]),
                        //   ),
                        // )
                      ],
                    )
                  ],
                ))

        // ]
        // ),
        );
  }
}
