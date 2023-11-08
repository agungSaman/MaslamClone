class KegiatanBannerListModel {
  final String urlImage;
  final String urlImageMaster;
  // final String deskripsi;

  KegiatanBannerListModel({
    required this.urlImage,
    required this.urlImageMaster,
    // required this.deskripsi
  });

  factory KegiatanBannerListModel.fromJson(Map<String, dynamic> json) =>
      KegiatanBannerListModel(
        urlImage: json['nama_file'] ?? '',
        urlImageMaster: json['nama_file_master'] ?? '',
      );
}
