class Penghasilan {
  final String penghasilanId;
  final String nama;
  final String namaEn;

  Penghasilan(
      {required this.penghasilanId, required this.nama, required this.namaEn});

  factory Penghasilan.fromJson(Map<String, dynamic> json) => Penghasilan(
      penghasilanId: json['penghasilan_id'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
