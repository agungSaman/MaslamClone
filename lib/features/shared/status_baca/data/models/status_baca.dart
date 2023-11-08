class StatusBaca {
  final String statusBacaId;
  final String nama;
  final String namaEn;

  StatusBaca(
      {required this.statusBacaId, required this.nama, required this.namaEn});

  factory StatusBaca.fromJson(Map<String, dynamic> json) => StatusBaca(
      statusBacaId: json['status_baca_alquran_id'],
      nama: json['nama'],
      namaEn: json['nama_en']);
}
