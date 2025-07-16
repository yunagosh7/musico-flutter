  import 'package:flutter/material.dart';
  import 'package:flutter_svg/svg.dart';
  import 'package:go_router/go_router.dart';
  import 'package:musico_app/providers/track.dart';
  import 'package:musico_app/theme/colors.dart';
  import 'package:musico_app/widgets/organisms/track_player/index.dart';
  import 'package:provider/provider.dart';

  class PageTemplate extends StatelessWidget {
    final Widget child;

    PageTemplate({super.key, required this.child});

    final List<Map<String, dynamic>> navItems = [
      {
        'icon': Icon(Icons.home_outlined),
        'iconSelect': Icon(Icons.home),
        'label': 'Home',
        'route': "/"
      },
      {
        'icon': Icon(Icons.search),
        'iconSelect': SvgPicture.asset('assets/search_selected_icon.svg'),
        'label': 'Search',
        'route': "/search",
      },
      {
        'icon': Icon(Icons.library_music_outlined),
        'iconSelect': Icon(Icons.library_music),
        'label': 'Your Library',
        'route': "/library",
      }
    ];

    int _getSelectedIndex(String currentRoute) {
      return navItems.indexWhere((item) => item['route'] == currentRoute);
    }

    @override
    Widget build(BuildContext context) {
      final tracksProvider = Provider.of<TracksProvider>(context);
      final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();


      int selectedIndex = _getSelectedIndex(currentRoute);
      selectedIndex = selectedIndex == -1 ? 0 : selectedIndex;

      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0x00FFFFFF),
          selectedItemColor: AppColors.white75,
          unselectedItemColor: AppColors.white75,
          onTap: (index) {
            final route = navItems[index]['route'];
            if (route != currentRoute) {
              context.go(route);
            }
          },
          items: List.generate(navItems.length, (index) {
            final item = navItems[index];
            final isSelected = selectedIndex == index;
            return BottomNavigationBarItem(
              icon: isSelected ? item['iconSelect'] : item['icon'],
              label: item['label'],
            );
          }),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                ),
              ),
              if (tracksProvider.track != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: TrackPlayer(track: tracksProvider.track),
                ),
            ],
          ),
        ),
      );
    }
  }
