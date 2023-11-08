class UserRequirement {
  final String alamatRumah;
  final String noHp;

  UserRequirement({
    required this.alamatRumah,
    required this.noHp,
  });

  factory UserRequirement.fromJson(Map<String, dynamic> json) =>
      UserRequirement(
        alamatRumah: json['alamat_rumah'] ?? '',
        noHp: json['no_hp'] ?? '',
      );
}
