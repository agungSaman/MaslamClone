class MasjidKegiatan {
  final int noUrut;
  final String nama;
  final String deskripsi;
  final String icon;

  MasjidKegiatan({
    required this.noUrut,
    required this.nama,
    required this.deskripsi,
    required this.icon,
  });

  factory MasjidKegiatan.fromJson(Map<String, dynamic> json) => MasjidKegiatan(
      noUrut: json['no_urut'] ?? 0,
      nama: json['nama'] ?? '-',
      deskripsi: json['deskripsi'] ?? '-',
      icon: json['icon'] ?? 'assets/logos/maslam_transparent_logo.png');
}
