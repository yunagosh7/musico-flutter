import 'package:dio/dio.dart';
import 'package:musico_app/models/playlist.dart';
import 'package:musico_app/services/index.dart';
import 'package:musico_app/services/spotify_auth.dart';

class PlaylistService {
  final SpotifyDioClient _dio = SpotifyDioClient();

  Future<Playlist> getPlaylist(String id) async {
    final response = await _dio.get('/playlists/$id');
    return Playlist.fromJson(response.data);
  }

  Future<List<Playlist>> getFeaturedPlaylists() async {
    final response = await _dio.get('/users/yunagosh/playlists');
    return FeaturedPlaylistResponseWrapper.fromJson(response.data).items;
  }
}