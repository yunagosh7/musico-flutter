import 'package:musico_app/models/artist.dart';
import 'package:musico_app/models/spotify_image.dart';

class Track {
  String id;
  String name;
  String? preview_url; // link to mp3 preview
  bool? explicit;
  List<SpotifyImage?> images;
  List<Artist>? artists;

  Track({
    required this.id,
    required this.name,
    this.preview_url,
    this.explicit,
    required this.images,
    this.artists,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      explicit: json['explicit'],
      preview_url: json['preview_url'],
      images:
          (json['album']['images'] as List)
              .map((img) => SpotifyImage.fromJson(img))
              .toList(),
      artists: (json['artists'] as List<dynamic>?)?.map((artist) => Artist.fromJson(artist)).toList(),
    );
  }
}

class TrackListResponseWrapper {
  List<Track?> tracks;

  TrackListResponseWrapper({required this.tracks});

  factory TrackListResponseWrapper.fromJson(Map<String, dynamic> json) {
    return TrackListResponseWrapper(
      tracks:
          (json['tracks'] as List)
              .map((track) => Track.fromJson(track))
              .toList(),
    );
  }
}
