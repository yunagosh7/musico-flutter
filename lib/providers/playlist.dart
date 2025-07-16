import 'package:flutter/material.dart';
import 'package:musico_app/models/playlist.dart';
import 'package:musico_app/services/playlist.dart';

class PlaylistProvider extends ChangeNotifier {
  late final _playlistService = PlaylistService();

  Playlist? playlist;
  List<Playlist> featuredPlaylists =[];
  bool isLoading = false;
  String? error;

  Future<void> getPlaylist(String id) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      playlist = await _playlistService.getPlaylist(id);
    } catch(er) {
      error = er.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
   Future<void> getFeaturedPlaylists() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      featuredPlaylists = await _playlistService.getFeaturedPlaylists();
      print('$featuredPlaylists');
    } catch(er) {
      error = er.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
}