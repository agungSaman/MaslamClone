class Pekerjaan {
  final String pekerjaanId;
  final String nama;
  final String namaEn;

  Pekerjaan(
      {required this.pekerjaanId, required this.nama, required this.namaEn});

  factory Pekerjaan.fromJson(Map<String, dynamic> json) => Pekerjaan(
      pekerjaanId: json['pekerjaan_id'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
