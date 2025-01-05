import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_persistence.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/cal/cal_loader.dart';
import 'package:hamikdash_sheli/dataTypes/user.dart';
import 'package:hamikdash_sheli/korbanot_config_files_loader.dart';
import 'package:hamikdash_sheli/pages/welcome_page.dart';

import 'package:timezone/data/latest_10y.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  CalLoader().loadAsset();
  KorbanotConfigFilesLoader().load();
  await appPersistence.load();

  tz.initializeTimeZones();
  
  appState.user = User(name: "meir", email:"a@b.com");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'בית הבחירה',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

