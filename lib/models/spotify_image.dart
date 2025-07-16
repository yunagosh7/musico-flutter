class SpotifyImage {
  String url;
  int? height;
  int? width;

  SpotifyImage({
    required this.url,
    this.height,
    this.width
  });

  factory SpotifyImage.fromJson(Map<String, dynamic> json) {
    return SpotifyImage(
      url: json['url'],
      height: json['height'],
      width: json['width']
    );
  }
}