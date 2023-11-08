class StatusRumah {
  final String statusRumahId;
  final String nama;
  final String namaEn;

  StatusRumah(
      {required this.statusRumahId, required this.nama, required this.namaEn});

  factory StatusRumah.fromJson(Map<String, dynamic> json) => StatusRumah(
      statusRumahId: json['status_rumah_id'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
