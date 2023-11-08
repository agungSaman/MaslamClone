class NearestPrayTime {
  final String waktuSholat;
  final String tanggalWaktuSholat;
  final String waktu;

  NearestPrayTime(
      {required this.waktuSholat,
      required this.tanggalWaktuSholat,
      required this.waktu});

  factory NearestPrayTime.fromJson(Map<String, dynamic> json) =>
      NearestPrayTime(
          waktuSholat: json['waktu_sholat'] ?? '-',
          tanggalWaktuSholat: json['tanggal_waktu_sholat'],
          waktu: json['waktu']);
}
