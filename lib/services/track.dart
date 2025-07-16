import 'package:dio/dio.dart';
import 'package:musico_app/models/track.dart';
import 'package:musico_app/services/spotify_auth.dart';

class TrackService {
  final SpotifyDioClient _dio = SpotifyDioClient();

  Future<Track> getTrack(String id) async {
    final response = await _dio.get('/tracks/$id');
    return Track.fromJson(response.data);
  }

  Future<List<Track?>> getTrackList() async {
    final response = await _dio.get('/tracks?ids=7ouMYWpwJ422jRcDASZB7P,4VqPOruhp5EdPBeR92t6lQ,2takcwOaAZWiXQijPHIx7B,2mRwodUOATBk5spcUsEidB,0jwzSY6F8R9iohGU7bn4uy');
    print("track list response: $response");
    return TrackListResponseWrapper.fromJson(response.data).tracks;
  }
}