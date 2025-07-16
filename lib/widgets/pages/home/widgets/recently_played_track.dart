import 'package:flutter/material.dart';
import 'package:musico_app/models/track.dart';
import 'package:musico_app/theme/colors.dart';

class RecentlyPlayedTrack extends StatelessWidget {
  Track? track;

  final void Function(String trackId) onTap;

  RecentlyPlayedTrack({super.key, this.track, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: GestureDetector(
        onTap: () => onTap(track?.id ?? ""),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                track?.images[0]?.url ?? "",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: IconButton(
                    iconSize: 16,
                    onPressed: () {
                      onTap(track?.id ?? "");
                    },
                    icon: Icon(Icons.play_arrow),
                    style: IconButton.styleFrom(
                      fixedSize: Size(10, 10),
                      backgroundColor: AppColors.white75,
                      foregroundColor: AppColors.background,
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   width: 100,
    //   height: 100,
    //   child: Stack(
    //     children: [
    //       Image.network(
    //         track?.images[0]?.url ?? "",
    //         fit: BoxFit.cover,
    //         errorBuilder: (context, error, stackTrace) {
    //           return Container(
    //             color: Colors.grey[300],
    //             child: const Icon(
    //               Icons.music_note,
    //               size: 50,
    //               color: Colors.grey,
    //             ),
    //           );
    //         },
    //       ),
    //       IconButton(
    //         iconSize: 16,
    //         onPressed: () {},
    //         icon: Icon(Icons.play_arrow),
    //         style: IconButton.styleFrom(
    //           fixedSize: Size(10, 10),
    //           backgroundColor: AppColors.white75,
    //           foregroundColor: AppColors.background,
    //           shape: CircleBorder(),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
