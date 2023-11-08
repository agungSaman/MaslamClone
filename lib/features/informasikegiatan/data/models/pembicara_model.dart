class PembicaraModel {
  final String kegiatanPembicaraId;
  final String kegiatanId;
  final int noUrut;
  final String pembicaraId;
  final String pembicaraNama;
  final String profil;
  final String jenisKelaminKode;
  final String jenisKelaminNama;
  final String namaFile;
  final String namaFileDefault;

  PembicaraModel({
    required this.kegiatanPembicaraId,
    required this.kegiatanId,
    required this.noUrut,
    required this.pembicaraId,
    required this.pembicaraNama,
    required this.profil,
    required this.jenisKelaminKode,
    required this.jenisKelaminNama,
    required this.namaFile,
    required this.namaFileDefault,
  });

  factory PembicaraModel.fromJson(Map<String, dynamic> json) => PembicaraModel(
        kegiatanPembicaraId: json['kegiatan_pembicara_id'] ?? '-',
        kegiatanId: json['kegiatan_id'] ?? '-',
        noUrut: json['no_urut'] ?? '-',
        pembicaraId: json['pembicara_id'] ?? '-',
        pembicaraNama: json['pembicara_nama'] ?? '-',
        profil: json['profil'] ?? '-',
        jenisKelaminKode: json['jenis_kelamin_kode'] ?? '-',
        jenisKelaminNama: json['jenis_kelamin_nama'] ?? '-',
        namaFile: json['nama_file'] ?? '',
        namaFileDefault: json['nama_file_default'] ?? '',
      );
}
