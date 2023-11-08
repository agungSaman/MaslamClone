class MyMasjidList {
  final String masjidId;
  final String namaMasjid;
  final String alamat;
  final String namaKelurahan;
  final String namaKecamatan;
  final String namaKota;
  final String aksi;
  final String keteranganAksi;
  final bool isJamaah;
  final bool isBookmark;
  final bool isLike;
  final String urlImage;

  MyMasjidList(
      {required this.masjidId,
      required this.namaMasjid,
      required this.alamat,
      required this.namaKelurahan,
      required this.namaKecamatan,
      required this.namaKota,
      required this.aksi,
      required this.keteranganAksi,
      required this.isJamaah,
      required this.isBookmark,
      required this.isLike,
      required this.urlImage});

  factory MyMasjidList.fromJson(Map<String, dynamic> json) => MyMasjidList(
        masjidId: json['masjid_id'] ?? '-',
        namaMasjid: json['nama'] ?? '-',
        alamat: json['alamat'] ?? '-',
        namaKelurahan: json['kelurahan_nama'] ?? '-',
        namaKecamatan: json['kecamatan_nama'] ?? '-',
        namaKota: json['kota_nama'] ?? '-',
        aksi: json['aksi'] ?? '-',
        keteranganAksi: json['keterangan_aksi'] ?? '-',
        isJamaah: json['is_jamaah'] ?? false,
        isBookmark: json['is_bookmark'] ?? false,
        isLike: json['is_like'] ?? false,
        urlImage: json['nama_file'] ?? '-',
      );
}
