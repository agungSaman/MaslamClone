class PrayTime {
  final String tanggal;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;

  PrayTime(
      {required this.tanggal,
      required this.imsak,
      required this.subuh,
      required this.terbit,
      required this.dzuhur,
      required this.ashar,
      required this.maghrib,
      required this.isya});

  factory PrayTime.fromJson(Map<String, dynamic> json) => PrayTime(
      tanggal: json['tanggal'] ?? '-',
      imsak: json['imsak'] ?? '-',
      subuh: json['subuh'],
      terbit: json['terbit'],
      dzuhur: json['dzuhur'],
      ashar: json['ashar'],
      maghrib: json['maghrib'],
      isya: json['isya']);
}
