class Gender {
  final String jkId;
  final String kode;
  final String nama;
  final String namaEn;

  Gender(
      {required this.jkId,
      required this.kode,
      required this.nama,
      required this.namaEn});

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
      jkId: json['jenis_kelamin_id'],
      kode: json['kode'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
