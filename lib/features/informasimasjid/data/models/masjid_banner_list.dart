class MasjidBannerList {
  final String urlImage;

  MasjidBannerList({required this.urlImage});

  factory MasjidBannerList.fromJson(Map<String, dynamic> json) =>
      MasjidBannerList(
        urlImage: json['nama_file'] ?? '-',
      );
}
