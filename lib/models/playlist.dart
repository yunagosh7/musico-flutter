import 'package:musico_app/models/spotify_image.dart';
import 'package:musico_app/models/track.dart';

class PlaylistTrack {
  List<Track> data;

  PlaylistTrack({required this.data});

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List? ?? [];
    return PlaylistTrack(
      data: data.map((track) => Track.fromJson(track)).toList(),
    );
  }
}

class Playlist {
  String id;
  String name;
  String? description;

  // PlaylistTrack tracks;
  List<SpotifyImage>? images;

  Playlist({
    required this.id,
    required this.name,
    this.description,
    // required this.tracks,
    this.images,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      // tracks: PlaylistTrack.fromJson(json['tracks']),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((img) => SpotifyImage.fromJson(img))
              .toList(),
    );
  }

}

class FeaturedPlaylistResponseWrapper {
  List<Playlist> items;

  FeaturedPlaylistResponseWrapper({required this.items});

  factory FeaturedPlaylistResponseWrapper.fromJson(Map<String, dynamic> json) {
    return FeaturedPlaylistResponseWrapper(
      items:
          (json['items'] as List)
              .map((item) => Playlist.fromJson(item))
              .toList(),
    );
  }
}
