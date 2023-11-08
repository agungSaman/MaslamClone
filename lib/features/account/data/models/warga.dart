class Warga {
  final String wargaId;
  final String userId;
  final String memberSince;
  final String createdDate;
  final String nama;
  final String jenisKelaminId;
  final String jenisKelaminNama;
  final String tempatLahir;
  final String tglLahir;
  final String daerahAsal;
  final String noKtp;
  final String alamatRumah;
  // final String longitude;
  // final String latitude;
  final String statusRumahId;
  final String statusRumahNama;
  final int tahunDomisili;
  final String golonganDarah;
  final String pendidikanId;
  final String pendidikanNama;
  final String pekerjaanId;
  final String pekerjaanNama;
  final String pekerjaanLain;
  final String namaPerusahaan;
  final String jenisUsaha;
  final String keahlian;
  final String statusBacaAlquranId;
  final String statusBacaAlquranNama;
  final bool isHaji;
  final String noHp;
  final String email;
  final String penghasilanId;
  final String penghasilanNama;
  final int jumlahTanggungan;
  final bool isMeninggal;
  final String tglMeninggal;
  final bool isFoto;
  final String fotoExt;
  final String namaFile;

  Warga({
    required this.wargaId,
    required this.userId,
    required this.memberSince,
    required this.createdDate,
    required this.nama,
    required this.jenisKelaminId,
    required this.jenisKelaminNama,
    required this.tempatLahir,
    required this.tglLahir,
    required this.daerahAsal,
    required this.noKtp,
    required this.alamatRumah,
    // required this.longitude,
    // required this.latitude,
    required this.statusRumahId,
    required this.statusRumahNama,
    required this.tahunDomisili,
    required this.golonganDarah,
    required this.pendidikanId,
    required this.pendidikanNama,
    required this.pekerjaanId,
    required this.pekerjaanNama,
    required this.pekerjaanLain,
    required this.namaPerusahaan,
    required this.jenisUsaha,
    required this.keahlian,
    required this.statusBacaAlquranId,
    required this.statusBacaAlquranNama,
    required this.isHaji,
    required this.noHp,
    required this.email,
    required this.penghasilanId,
    required this.penghasilanNama,
    required this.jumlahTanggungan,
    required this.isMeninggal,
    required this.tglMeninggal,
    required this.isFoto,
    required this.fotoExt,
    required this.namaFile,
  });

  factory Warga.fromJson(Map<String, dynamic> json) => Warga(
        wargaId: json['warga_id'] ?? '-',
        userId: json['user_id'] ?? '-',
        memberSince: json['member_since'] ?? '',
        createdDate: json['created_date'] ?? '',
        nama: json['nama'] ?? '-',
        jenisKelaminId: json['jenis_kelamin_id'] ?? '-',
        jenisKelaminNama: json['jenis_kelamin_nama'] ?? '-',
        tempatLahir: json['tempat_lahir'] ?? '-',
        tglLahir: json['tgl_lahir'] ?? '',
        daerahAsal: json['daerah_asal'] ?? '-',
        noKtp: json['no_ktp'] ?? '-',
        alamatRumah: json['alamat_rumah'] ?? '-',
        // longitude: json['longitude'] ?? '0',
        // latitude: json['latitude'] ?? '0',
        statusRumahId: json['status_rumah_id'] ?? '-',
        statusRumahNama: json['status_rumah_nama'] ?? '-',
        tahunDomisili: json['tahun_domisili'] ?? 1990,
        golonganDarah: json['golongan_darah'] ?? '-',
        pendidikanId: json['pendidikan_id'] ?? '-',
        pendidikanNama: json['pendidikan_nama'] ?? '-',
        pekerjaanId: json['pekerjaan_id'] ?? '-',
        pekerjaanNama: json['pekerjaan_nama'] ?? '-',
        pekerjaanLain: json['pekerjaan_lain'] ?? '-',
        namaPerusahaan: json['nama_perusahaan'] ?? '-',
        jenisUsaha: json['jenis_usaha'] ?? '-',
        keahlian: json['keahlian'] ?? '-',
        statusBacaAlquranId: json['status_baca_alquran_id'] ?? '-',
        statusBacaAlquranNama: json['status_baca_alquran_nama'] ?? '-',
        isHaji: json['is_haji'],
        noHp: json['no_hp'] ?? '-',
        email: json['email'] ?? '-',
        penghasilanId: json['penghasilan_id'] ?? '-',
        penghasilanNama: json['penghasilan_nama'] ?? '-',
        jumlahTanggungan: json['jumlah_tanggungan'] ?? 0,
        isMeninggal: json['is_meninggal'],
        tglMeninggal: json['tgl_meninggal'] ?? '',
        isFoto: json['is_foto'],
        fotoExt: json['foto_ext'] ?? '-',
        namaFile: json['nama_file'] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        'warga_id': wargaId,
        'user_id': userId,
        'member_since': memberSince,
        'created_date': createdDate,
        'nama': nama,
        'jenis_kelamin_id': jenisKelaminId,
        'jenis_kelamin_nama': jenisKelaminNama,
        'tempat_lahir': tempatLahir,
        'tgl_lahir': tglLahir,
        'daerah_asal': daerahAsal,
        'no_ktp': noKtp,
        'alamat_rumah': alamatRumah,
        // 'longitude': longitude,
        // 'latitude': latitude,
        'status_rumah_id': statusRumahId,
        'status_rumah_nama': statusRumahNama,
        'tahun_domisili': tahunDomisili,
        'golongan_darah': golonganDarah,
        'pendidikan_id': pendidikanId,
        'pendidikan_nama': pendidikanNama,
        'pekerjaan_id': pekerjaanId,
        'pekerjaan_nama': pekerjaanNama,
        'pekerjaan_lain': pekerjaanLain,
        'nama_perusahaan': namaPerusahaan,
        'jenis_usaha': jenisUsaha,
        'keahlian': keahlian,
        'status_baca_alquran_id': statusBacaAlquranId,
        'status_baca_alquran_nama': statusBacaAlquranNama,
        'is_haji': isHaji,
        'no_hp': noHp,
        'email': email,
        'penghasilan_id': penghasilanId,
        'penghasilan_nama': penghasilanNama,
        'jumlah_tanggungan': jumlahTanggungan,
        'is_meninggal': isMeninggal,
        'tgl_meninggal': tglMeninggal,
        'is_foto': isFoto,
        'foto_ext': fotoExt,
      };
}
