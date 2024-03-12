import 'package:flame/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wildrun/models/task_data.dart';
import 'package:wildrun/widgets/info_menu.dart';
import 'package:wildrun/widgets/stat_menu.dart';
import 'package:wildrun/widgets/tuto_menu.dart';
import 'package:wildrun/widgets/task_menu.dart';

import 'widgets/hud.dart';
import 'game/wildrun.dart';
import 'models/settings.dart';
import 'widgets/main_menu.dart';
import 'models/player_data.dart';
import 'widgets/pause_menu.dart';
import 'widgets/settings_menu.dart';
import 'widgets/game_over_menu.dart';

// Main function to initialize the game
Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive for local data storage
  await initHive();
  // Run the WildRunApp
  runApp(const WildRunApp());
}

// Function to initialize Hive for local data storage
Future<void> initHive() async {
  if (!kIsWeb) {
    // Get the directory for application documents
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
  Hive.registerAdapter<TaskData>(TaskDataAdapter());
}

// Main application widget
class WildRunApp extends StatelessWidget {
  const WildRunApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wild Run',
      theme: ThemeData(
        fontFamily: 'Oswald',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              fixedSize: const Size(200, 60),
              foregroundColor: const Color.fromARGB(255, 0, 191, 99),
              backgroundColor: const Color.fromARGB(255, 255, 222, 89),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color.fromARGB(185, 226, 226, 226),
          ),
        ),
      ),
      // Scaffold widget as the main container
      home: Scaffold(
        // GameWidget to handle the game lifecycle
        body: GameWidget<WildRun>.controlled(
          loadingBuilder: (context) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                color: Color.fromARGB(255, 0, 191, 99),
              ),
            ),
          ),
          // Map of overlay widgets to be displayed over the game
          overlayBuilderMap: {
            MainMenu.id: (_, game) => MainMenu(game),
            PauseMenu.id: (_, game) => PauseMenu(game),
            Hud.id: (_, game) => Hud(game),
            GameOverMenu.id: (_, game) => GameOverMenu(game),
            SettingsMenu.id: (_, game) => SettingsMenu(game),
            TutoMenu.id: (_, game) => TutoMenu(game),
            TaskMenu.id: (_, game) => TaskMenu(game),
            StatMenu.id: (_, game) => StatMenu(game),
            InfoMenu.id: (_, game) => InfoMenu(game),
          },
          // Initial active overlays for the game
          initialActiveOverlays: const [MainMenu.id],
          // Factory method to create the WildRun game instance
          gameFactory: () => WildRun(
              camera:
                  CameraComponent.withFixedResolution(width: 360, height: 180),
              sizeScreen: MediaQuery.of(context).size),
        ),
      ),
    );
  }
}
