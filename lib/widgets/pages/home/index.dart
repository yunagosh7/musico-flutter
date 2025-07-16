import 'package:flutter/material.dart';
import 'package:musico_app/providers/playlist.dart';
import 'package:musico_app/providers/track.dart';
import 'package:musico_app/theme/colors.dart';
import 'package:musico_app/widgets/pages/home/widgets/featured_playlist.dart';
import 'package:musico_app/widgets/pages/home/widgets/recently_played_track.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final tracksProvider = Provider.of<TracksProvider>(
          context,
          listen: false,
        );
        final playlistProvider = Provider.of<PlaylistProvider>(
          context,
          listen: false,
        );
        try {
          tracksProvider.fetchTrackList();
          playlistProvider.getPlaylist('3cEYpjA9oz9GiPac4AsH4n');
          playlistProvider.getFeaturedPlaylists();
        } catch (er) {
          print("error: $er");
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final playlistProvider = Provider.of<PlaylistProvider>(
      context,
      listen: true,
    );
    final tracksProvider = Provider.of<TracksProvider>(context, listen: true);

    return
    //  PageTemplate(
    //   child: 
      SingleChildScrollView(
        child: Column(
          children: [
            if (isLoading == true)
              Center(child: CircularProgressIndicator())
            else if (playlistProvider.error != null ||
                tracksProvider.error != null)
              Text(
                "an error has ocurred ${playlistProvider.error} ${tracksProvider.error}",
                style: Theme.of(context).textTheme.headlineLarge,
              )
            else ...[
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👋 Hi Logan",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Good evening",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person, color: AppColors.background),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.white75,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: Text("For you"),
                    selected: true,
                    onSelected: (_) {},
                  ),
                  ChoiceChip(
                    label: Text("Relax"),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  ChoiceChip(
                    label: Text("Workout"),
                    selected: false,
                    onSelected: (_) {},
                  ),
                  ChoiceChip(
                    label: Text("Travel"),
                    selected: false,
                    onSelected: (_) {},
                  ),
                ],
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Featuring today",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 16),
                  itemBuilder:
                      (context, index) => FeaturedPlaylist(
                        playlist: playlistProvider.featuredPlaylists[index],
                      ),
                  itemCount: playlistProvider.featuredPlaylists.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recently Played",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder:
                      (context, index) => RecentlyPlayedTrack(
                        track: tracksProvider.trackList[index],
                        onTap: (String trackId) {
                          tracksProvider.fetchTrack(trackId);
                        },
                      ),
                  itemCount: tracksProvider.trackList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
            // TrackPlayer(track: tracksProvider.track),
          ],
        ),
      // ),
    );
  }
}
