import 'package:flame/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wildrun/game/wildrun.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(const WildRunApp());
}

Future<void> initHive() async {
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  //Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  //Hive.registerAdapter<Settings>(SettingsAdapter());
}

class WildRunApp extends StatelessWidget {
  const WildRunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wild Run',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget<WildRun>.controlled(
          // add a loading bar during charging the game
          loadingBuilder: (context) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),

          overlayBuilderMap: {
            /*
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
            */
          },
          //initialActiveOverlays: const [MainMenu.id],

          gameFactory: () => WildRun(
              camera:
                  CameraComponent.withFixedResolution(width: 360, height: 180)),
        ),
      ),
    );
  }
}
