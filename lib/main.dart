import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musico_app/providers/playlist.dart';
import 'package:musico_app/providers/track.dart';
import 'package:musico_app/router/index.dart';
import 'package:musico_app/theme/index.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: ".env",
  );
  runApp(
    MultiProvider(providers: 
      [
        ChangeNotifierProvider(create: (_) => TracksProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: MyApp(),
    ),
    // const MyApp()
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: createAppTheme(),
      routerConfig: appRouter,
    );
  }
}
