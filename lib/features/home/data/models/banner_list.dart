class BannerList {
  final String urlImage;

  BannerList({required this.urlImage});

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        urlImage: json['nama_file'] ?? '-',
      );
}
