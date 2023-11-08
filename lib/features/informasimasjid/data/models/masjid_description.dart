class MasjidDescription {
  final String masjidId;
  final String profile;
  final String noTelp;
  final String email;
  final String namaKelurahan;
  final String namaKota;

  MasjidDescription({
    required this.masjidId,
    required this.profile,
    required this.noTelp,
    required this.email,
    required this.namaKelurahan,
    required this.namaKota,
  });

  factory MasjidDescription.fromJson(Map<String, dynamic> json) =>
      MasjidDescription(
        masjidId: json['masjid_id'] ?? '-',
        profile: json['profile'] ?? '-',
        noTelp: json['no_telp'] ?? '-',
        email: json['email'] ?? '-',
        namaKelurahan: json['kelurahan_nama'] ?? '-',
        namaKota: json['kota_nama'] ?? '-',
      );
}
