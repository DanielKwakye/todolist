import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/app/app.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/firebase_options.dart';
import 'core/utils/injector.dart' as di;

Future<void> main() async {

  // Ensure all dependencies are initialized
  WidgetsFlutterBinding.ensureInitialized();
  //only portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // so that the status bar will show on IOS
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);

  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // All dependence injections
  // dependencies are registered lazily to boost app performance
  await di.init();

  // local db
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());


  // get current theme mode
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(App(savedThemeMode:  savedThemeMode));
}

