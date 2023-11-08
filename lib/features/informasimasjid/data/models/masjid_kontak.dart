class MasjidKontak {
  final String sosmedNama;
  final int noUrut;
  final String url;
  final String icon;

  MasjidKontak({
    required this.sosmedNama,
    required this.noUrut,
    required this.url,
    required this.icon,
  });

  factory MasjidKontak.fromJson(Map<String, dynamic> json) => MasjidKontak(
      sosmedNama: json['sosmed_nama'] ?? '-',
      noUrut: json['no_urut'] ?? 0,
      url: json['url'] ?? '-',
      icon: json['icon'] ?? 'assets/icons/mosque.png');
}
