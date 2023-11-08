class InformasiKegiatan {
  final String kegiatanId;
  final String createdBy;
  final String createdName;
  final String createdDate;
  final String updatedBy;
  final String updatedName;
  final String lastUpdated;
  final String rowversion;
  final String masjidId;
  final String masjidNama;
  final double latitude;
  final double longitude;
  final double distance;
  final String masterKategoriKegiatanId;
  final String kategoriKegiatanNama;
  final String kategoriKegiatanNamaEn;
  final String judul;
  final String deskripsi;
  final String tempat;
  final String tanggal;
  final String jamMulai;
  final String jamSelesai;
  final String masjidKategoriPesertaKegiatanId;
  final String kategoriPesertaKegiatanNama;
  final String kategoriPesertaKegiatanNamaEn;
  final bool isBayar;
  final double biaya;
  final bool isKuota;
  final int kuota;
  final String catatan;
  final String daftarPembicara;
  final String kegiatanBannerId;
  final String formatFile;
  final String masjidKategoriPesertaKegiatanNama;
  final String tanggalDanJam;
  final String masterKategoriKegiatanNama;
  final String namaFile;
  final String namaFileMaster;

  InformasiKegiatan({
    required this.kegiatanId,
    required this.createdBy,
    required this.createdName,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedName,
    required this.lastUpdated,
    required this.rowversion,
    required this.masjidId,
    required this.masjidNama,
    required this.latitude,
    required this.longitude,
    required this.distance,
    required this.masterKategoriKegiatanId,
    required this.kategoriKegiatanNama,
    required this.kategoriKegiatanNamaEn,
    required this.judul,
    required this.deskripsi,
    required this.tempat,
    required this.tanggal,
    required this.jamMulai,
    required this.jamSelesai,
    required this.masjidKategoriPesertaKegiatanId,
    required this.kategoriPesertaKegiatanNama,
    required this.kategoriPesertaKegiatanNamaEn,
    required this.isBayar,
    required this.biaya,
    required this.isKuota,
    required this.kuota,
    required this.catatan,
    required this.daftarPembicara,
    required this.kegiatanBannerId,
    required this.formatFile,
    required this.masjidKategoriPesertaKegiatanNama,
    required this.tanggalDanJam,
    required this.masterKategoriKegiatanNama,
    required this.namaFile,
    required this.namaFileMaster,
  });

  factory InformasiKegiatan.fromJson(Map<String, dynamic> json) =>
      InformasiKegiatan(
        kegiatanId: json['kegiatan_id'] ?? '-',
        createdBy: json['created_by'] ?? '-',
        createdName: json['created_name'] ?? '-',
        createdDate: json['created_date'] ?? '-',
        updatedBy: json['updated_by'] ?? '-',
        updatedName: json['updated_name'] ?? '-',
        lastUpdated: json['last_updated'] ?? '-',
        rowversion: json['rowversion'] ?? '-',
        masjidId: json['masjid_id'] ?? '-',
        masjidNama: json['masjid_nama'] ?? '-',
        latitude: json['latitude'] + 0.00,
        longitude: json['longitude'] + 0.00,
        distance: json['distance'] + 0.00,
        masterKategoriKegiatanId: json['master_kategori_kegiatan_id'] ?? '-',
        kategoriKegiatanNama: json['kategori_kegiatan_nama'] ?? '-',
        kategoriKegiatanNamaEn: json['kategori_kegiatan_nama_en'] ?? '-',
        judul: json['judul'] ?? '-',
        deskripsi: json['deskripsi'] ?? '-',
        tempat: json['tempat'] ?? '-',
        tanggal: json['tanggal'] ?? '-',
        jamMulai: json['jam_mulai'] ?? '-',
        jamSelesai: json['jam_selesai'] ?? '-',
        masjidKategoriPesertaKegiatanId:
            json['masjid_kategori_peserta_kegiatan_id'] ?? '-',
        kategoriPesertaKegiatanNama:
            json['kategori_peserta_kegiatan_nama'] ?? '-',
        kategoriPesertaKegiatanNamaEn:
            json['kategori_peserta_kegiatan_nama_en'] ?? '-',
        isBayar: json['is_bayar'] ?? '-',
        biaya: json['biaya'] ?? '-',
        isKuota: json['is_kuota'] ?? '-',
        kuota: json['kuota'] ?? '-',
        catatan: json['catatan'] ?? '-',
        daftarPembicara: json['daftar_pembicara'] ?? '-',
        kegiatanBannerId: json['kegiatan_banner_id'] ?? '-',
        formatFile: json['format_file'] ?? '-',
        masjidKategoriPesertaKegiatanNama:
            json['masjid_kategori_peserta_kegiatan_nama'] ?? '-',
        tanggalDanJam: json['tanggal_dan_jam'] ?? '-',
        masterKategoriKegiatanNama:
            json['master_kategori_kegiatan_nama'] ?? '-',
        namaFile: json['nama_file'] ?? '',
        namaFileMaster: json['nama_file_master'] ?? '',
      );
}
