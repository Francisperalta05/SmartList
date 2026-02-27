import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init DI + DB (SQLite) y cualquier servicio core.
  await Injector.init();

  runApp(const MyApp());
}
