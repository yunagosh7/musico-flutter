import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:musico_app/models/playlist.dart';
import 'package:musico_app/services/playlist.dart';
import 'package:musico_app/theme/colors.dart';

class PlaylistDetailsPage extends StatefulWidget {
  final String playlistId;

  PlaylistDetailsPage({super.key, required this.playlistId});

  @override
  _PlaylistDetailsPageState createState() => _PlaylistDetailsPageState();
}

class _PlaylistDetailsPageState extends State<PlaylistDetailsPage> {
  Playlist? playlist;
  bool isLoading = true;

  Future<void> getPlaylistDetails(String id) async {
    try {
      final response = await PlaylistService().getPlaylist(widget.playlistId);
      setState(() {
        playlist = response;
      });
    } catch (er) {
      print("error: $er");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    // playlist = Playlist.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        getPlaylistDetails(widget.playlistId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    final followers = playlist?.followers ?? 0;
    final tracks = playlist?.tracks ?? [];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: [
              Image.network(
                playlist?.images?[0]?.url ?? "",
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => context.pop(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  playlist?.name ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  "$followers likes",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Text(" • "),
                Text(
                  "${tracks.length} songs",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.download_for_offline_outlined),
                  onPressed: () {},
                ),
                IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                const Spacer(),
                IconButton(
                  iconSize: 48,
                  icon: const Icon(Icons.play_circle_fill),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final track = tracks[index];
            return ListTile(
              leading:
                  track.images[0]?.url != null
                      ? Image.network(
                        track.images[0]!.url,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                      : const Icon(Icons.music_note, size: 50),
              title: Text(track.name, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis,),
              subtitle: Text(
                "artist",
                // track.artists.map((a) => a.name).join(", ")
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white50),
                ),
              trailing: const Icon(Icons.more_vert),
            );
          }, childCount: tracks.length),
        ),
      ],
    );
  }
}
