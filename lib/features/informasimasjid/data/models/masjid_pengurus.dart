class MasjidPengurus {
  final String periodePengurusNama;
  final int noUrut;
  final String jabatan;
  final String nama;

  MasjidPengurus({
    required this.periodePengurusNama,
    required this.noUrut,
    required this.jabatan,
    required this.nama,
  });

  factory MasjidPengurus.fromJson(Map<String, dynamic> json) => MasjidPengurus(
      periodePengurusNama: json['periode_pengurus_nama'] ?? '-',
      noUrut: json['no_urut'] ?? 0,
      jabatan: json['jabatan'] ?? '-',
      nama: json['nama'] ?? '-');
}
