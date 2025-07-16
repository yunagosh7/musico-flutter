import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musico_app/models/track.dart';
import 'package:musico_app/theme/colors.dart';

class TrackPlayer extends StatefulWidget {
  final Track? track;

  const TrackPlayer({super.key, this.track});

  @override
  _TrackPlayerState createState() => _TrackPlayerState();
}

class _TrackPlayerState extends State<TrackPlayer> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    player.setUrl(
      widget.track?.preview_url ??
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Positioned(
              width: 700,
              height: 100,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(color: AppColors.white12),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),

              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.track?.images?[0]?.url ?? "",
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.track?.name ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            widget.track?.artists?[0].name ?? "Artist name",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Spacer(),
                      StreamBuilder<PlayerState>(
                        stream: player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final playing = playerState?.playing ?? false;
                          final processingState = playerState?.processingState;

                          if (processingState == ProcessingState.completed) {
                            return IconButton(
                              icon: const Icon(Icons.replay),
                              iconSize: 24,
                              onPressed: () => player.seek(Duration.zero),
                            );
                          }

                          return IconButton(
                            icon: Icon(
                              playing ? Icons.pause : Icons.play_arrow,
                            ),
                            iconSize: 24,
                            onPressed: playing ? player.pause : player.play,
                          );
                        },
                      ),
                    ],
                  ),
                  StreamBuilder<Duration?>(
                    stream: player.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;

                      return StreamBuilder<Duration>(
                        stream: player.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final clampedPosition =
                              position > duration ? duration : position;
                          return Column(
                            children: [
                              Slider(
                                inactiveColor: AppColors.white12,
                                activeColor: AppColors.white75,
                                min: 0.0,
                                max: duration.inMilliseconds.toDouble(),
                                value:
                                    clampedPosition.inMilliseconds.toDouble(),
                                onChanged: (value) {
                                  player.seek(
                                    Duration(milliseconds: value.toInt()),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

        // const SizedBox(height: 12),
      ],
    );
  }
}
