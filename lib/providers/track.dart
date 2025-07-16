import 'package:flutter/material.dart';
import 'package:musico_app/models/track.dart';
import 'package:musico_app/services/track.dart';

class TracksProvider extends ChangeNotifier {
  late final TrackService _trackService = TrackService();

  bool isLoading = false;
  Track? track;
  List<Track?> trackList = [];
  String? error;

  Future<void> fetchTrack(String id) async {
    if(id == track?.id) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      track = await _trackService.getTrack(id);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> fetchTrackList() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      trackList = await _trackService.getTrackList();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
