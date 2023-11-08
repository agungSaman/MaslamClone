class MasjidList {
  final String masjidId;
  final String namaMasjid;
  final String namaKelurahan;
  final String namaKecamatan;
  final String namaKota;
  final String waktuTempuh;
  final String jarak;
  final String urlImage;

  MasjidList(
      {required this.masjidId,
      required this.namaMasjid,
      required this.namaKelurahan,
      required this.namaKecamatan,
      required this.namaKota,
      required this.waktuTempuh,
      required this.jarak,
      required this.urlImage});

  factory MasjidList.fromJson(Map<String, dynamic> json) => MasjidList(
        masjidId: json['masjid_id'] ?? '-',
        namaMasjid: json['nama'] ?? '-',
        namaKelurahan: json['kelurahan_nama'] ?? '-',
        namaKecamatan: json['kecamatan_nama'] ?? '-',
        namaKota: json['kota_nama'] ?? '-',
        waktuTempuh: json['waktu_tempuh'] ?? '-',
        jarak: json['jarak'] ?? '-',
        urlImage: json['nama_file'] ?? '-',
      );
}
