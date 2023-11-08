class MasjidDetail {
  final String masjidId;
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
  final String alamat;
  final String propinsiId;
  final String propinsiNama;
  final String kotaId;
  final String kotaNama;
  final String kecamatanId;
  final String kecamatanNama;
  final String kelurahanId;
  final String kelurahanNama;
  final double distance;
  final double latitude;
  final double longitude;
  final String noTelp;
  final String email;
  final int tahunBerdiri;
  final double luasTanah;
  final double luasBangunan;
  final int dayaTampung;
  final String profile;
  final String profileEn;
  final String fotoProfile;
  final bool isMultiBahasa;
  final bool isStrukturJabatan;
  final bool isApprove;
  final bool isAktif;
  final bool isLaporanKeuanganPublik;
  final String timezoneId;
  final String namaTimezone;
  final String konfirmasiWaDonasi;
  final String jarak;
  final String waktuTempuh;
  final bool isJamaah;
  final bool isBookmark;
  final bool isLike;

  MasjidDetail({
    required this.masjidId,
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
    required this.alamat,
    required this.propinsiId,
    required this.propinsiNama,
    required this.kotaId,
    required this.kotaNama,
    required this.kecamatanId,
    required this.kecamatanNama,
    required this.kelurahanId,
    required this.kelurahanNama,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.noTelp,
    required this.email,
    required this.tahunBerdiri,
    required this.luasTanah,
    required this.luasBangunan,
    required this.dayaTampung,
    required this.profile,
    required this.profileEn,
    required this.fotoProfile,
    required this.isMultiBahasa,
    required this.isStrukturJabatan,
    required this.isApprove,
    required this.isAktif,
    required this.isLaporanKeuanganPublik,
    required this.timezoneId,
    required this.namaTimezone,
    required this.konfirmasiWaDonasi,
    required this.jarak,
    required this.waktuTempuh,
    required this.isJamaah,
    required this.isBookmark,
    required this.isLike,
  });

  factory MasjidDetail.fromJson(Map<String, dynamic> json) => MasjidDetail(
        masjidId: json['masjid_id'] ?? '-',
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
        alamat: json['alamat'] ?? '-',
        propinsiId: json['propinsi_id'] ?? '-',
        propinsiNama: json['propinsi_nama'] ?? '-',
        kotaId: json['kota_id'] ?? '-',
        kotaNama: json['kota_nama'] ?? '-',
        kecamatanId: json['kecamatan_id'] ?? '-',
        kecamatanNama: json['kecamatan_nama'] ?? '-',
        kelurahanId: json['kelurahan_id'] ?? '-',
        kelurahanNama: json['kelurahan_nama'] ?? '-',
        distance: json['distance'] + 0.00,
        latitude: json['latitude'] + 0.00,
        longitude: json['longitude'] + 0.00,
        noTelp: json['no_telp'] ?? '-',
        email: json['email'] ?? '-',
        tahunBerdiri: json['tahun_berdiri'] ?? 1990,
        luasTanah: json['luas_tanah'] + 0.00,
        luasBangunan: json['luas_bangunan'] + 0.00,
        dayaTampung: json['daya_tampung'] ?? 0,
        profile: json['profile'] ?? '-',
        profileEn: json['profile_en'] ?? '-',
        fotoProfile: json['foto_profile'] ?? '-',
        isMultiBahasa: json['is_multi_bahasa'] ?? '-',
        isStrukturJabatan: json['is_struktur_jabatan'] ?? false,
        isApprove: json['is_approve'] ?? false,
        isAktif: json['is_aktif'] ?? false,
        isLaporanKeuanganPublik: json['is_laporan_keuangan_publik'] ?? false,
        timezoneId: json['timezone_id'] ?? '-',
        namaTimezone: json['nama_timezone'] ?? '-',
        konfirmasiWaDonasi: json['konfirmasi_wa_donasi'] ?? '-',
        jarak: json['jarak'] ?? '-',
        waktuTempuh: json['waktu_tempuh'] ?? '-',
        isJamaah: json['is_jamaah'] ?? false,
        isBookmark: json['is_bookmark'] ?? false,
        isLike: json['is_like'] ?? false,
      );
}
