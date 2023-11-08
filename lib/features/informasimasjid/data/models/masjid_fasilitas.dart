class MasjidFasilitas {
  final String kategoriFasilitasNama;
  final int noUrut;
  final String namaFasilitas;
  final String icon;

  MasjidFasilitas({
    required this.kategoriFasilitasNama,
    required this.noUrut,
    required this.namaFasilitas,
    required this.icon,
  });

  factory MasjidFasilitas.fromJson(Map<String, dynamic> json) =>
      MasjidFasilitas(
          kategoriFasilitasNama: json['kategori_fasilitas_nama'] ?? '-',
          noUrut: json['no_urut'] ?? 0,
          namaFasilitas: json['nama_fasilitas'] ?? '-',
          icon: json['icon'] ?? 'assets/logos/maslam_transparent_logo.png');
}
