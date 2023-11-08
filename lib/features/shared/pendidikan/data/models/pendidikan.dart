class Pendidikan {
  final String pendidikanId;
  final String nama;
  final String namaEn;

  Pendidikan(
      {required this.pendidikanId, required this.nama, required this.namaEn});

  factory Pendidikan.fromJson(Map<String, dynamic> json) => Pendidikan(
      pendidikanId: json['pendidikan_id'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
