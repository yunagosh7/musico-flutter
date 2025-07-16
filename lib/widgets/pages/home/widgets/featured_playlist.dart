import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:musico_app/models/playlist.dart';

class FeaturedPlaylist extends StatelessWidget {
  Playlist? playlist;

  FeaturedPlaylist({super.key, this.playlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/playlist_details/${playlist?.id}'),
      child: SizedBox(
        height: 140,
        width: 280,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                playlist?.images?[0].url ?? "",
                fit: BoxFit.cover,
                width: 500,
                height: 140,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.music_note,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.90),
                      Color.fromRGBO(0, 0, 0, 0.70),
                      Color.fromRGBO(0, 0, 0, 0.50),
                      Color.fromRGBO(0, 0, 0, 0.30),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      playlist?.name ?? "no playlist name",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
