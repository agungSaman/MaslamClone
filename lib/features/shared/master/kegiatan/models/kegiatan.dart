class Kegiatan {
  final String masterKategoriKegiatanId;
  final String createdBy;
  final String createdName;
  final String createdDate;
  final String updatedBy;
  final String updatedName;
  final String lastUpdated;
  final String rowversion;
  final String negaraId;
  final String negaraNama;
  final String nama;
  final String namaEn;
  final String templateText;
  final String templateTextEn;
  final String icon;
  final String namaFile;
  final bool isAktif;

  Kegiatan({
    required this.masterKategoriKegiatanId,
    required this.createdBy,
    required this.createdName,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedName,
    required this.lastUpdated,
    required this.rowversion,
    required this.negaraId,
    required this.negaraNama,
    required this.nama,
    required this.namaEn,
    required this.templateText,
    required this.templateTextEn,
    required this.icon,
    required this.namaFile,
    required this.isAktif,
  });

  factory Kegiatan.fromJson(Map<String, dynamic> json) => Kegiatan(
        masterKategoriKegiatanId: json['master_kategori_kegiatan_id'] ?? '-',
        createdBy: json['created_by'] ?? '-',
        createdName: json['created_name'] ?? '-',
        createdDate: json['created_date'] ?? '-',
        updatedBy: json['updated_by'] ?? '-',
        updatedName: json['updated_name'] ?? '-',
        lastUpdated: json['last_updated'] ?? '-',
        rowversion: json['rowversion'] ?? '-',
        negaraId: json['negara_id'] ?? '-',
        negaraNama: json['negara_nama'] ?? '-',
        nama: json['nama'] ?? '-',
        namaEn: json['nama_en'] ?? '-',
        templateText: json['template_text'] ?? '-',
        templateTextEn: json['template_text_en'] ?? '-',
        icon: json['icon'] ?? '-',
        namaFile: json['nama_file'] ?? '-',
        isAktif: json['is_aktif'] ?? false,
      );
}
