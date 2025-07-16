import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:musico_app/widgets/pages/home/index.dart';
import 'package:musico_app/widgets/pages/library/index.dart';
import 'package:musico_app/widgets/pages/playlist_details/index.dart';
import 'package:musico_app/widgets/pages/playlist_list/index.dart';
import 'package:musico_app/widgets/pages/search/index.dart';
import 'package:musico_app/widgets/templates/page_template.dart'; // Asegurate de importar esto

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return PageTemplate(child: child); // <- no se vuelve a construir
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder:
              (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: '/search',
          pageBuilder:
              (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(child: SearchPage()),
        ),
        GoRoute(
          path: '/library',
          pageBuilder:
              (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(child: LibraryPage()),
        ),
        GoRoute(
          path: '/playlist_list',
          pageBuilder:
              (BuildContext context, GoRouterState state) =>
                  NoTransitionPage(child: PlaylistListPage()),
        ),
        GoRoute(
          path: '/playlist_details/:id',
          pageBuilder:
              (BuildContext context, GoRouterState state) => NoTransitionPage(
                child: PlaylistDetailsPage(
                  playlistId: state.pathParameters['id']!,
                ),
              ),
        ),
      ],
    ),
  ],
);
