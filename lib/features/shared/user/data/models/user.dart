class User {
  final String userId;
  final String nama;
  final String email;
  String password;
  final String fotoProfile;
  final String negaraId;
  final String negaraNama;
  final String bahasaId;
  final String bahasaNama;
  final String alamatRumah;
  final String noHp;
  final bool isVerified;
  final bool isAktif;
  final bool isPengurus;
  String token;
  final String tokenExpiredDate;

  User(
      {required this.userId,
      required this.nama,
      required this.email,
      required this.password,
      required this.fotoProfile,
      required this.negaraId,
      required this.negaraNama,
      required this.bahasaId,
      required this.bahasaNama,
      required this.alamatRumah,
      required this.noHp,
      required this.isVerified,
      required this.isAktif,
      required this.isPengurus,
      required this.token,
      required this.tokenExpiredDate});

  factory User.fromJson(Map<String, dynamic> json) => User(
      userId: json['user_id'],
      nama: json['nama'],
      email: json['email'],
      password: json['password'] ?? '',
      fotoProfile: json['foto_profile'] ?? '',
      negaraId: json['negara_id'],
      negaraNama: json['negara_nama'],
      bahasaId: json['bahasa_id'] ?? '',
      bahasaNama: json['bahasa_nama'] ?? '',
      alamatRumah: json['alamat_rumah'] ?? '',
      noHp: json['no_hp'] ?? '',
      isVerified: json['is_verified'],
      isAktif: json['is_aktif'],
      isPengurus: json['is_pengurus'],
      token: json['token'],
      tokenExpiredDate: json['token_expire_date']);

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'nama': nama,
        'email': email,
        'password': password,
        'foto_profile': fotoProfile,
        'negara_id': negaraId,
        'negara_nama': negaraNama,
        'bahasa_id': bahasaId,
        'bahasa_nama': bahasaNama,
        'alamat_rumah': alamatRumah,
        'no_hp': noHp,
        'is_verified': isVerified,
        'is_aktif': isAktif,
        'is_pengurus': isPengurus,
        'token': token,
        'token_expire_date': tokenExpiredDate
      };
}
