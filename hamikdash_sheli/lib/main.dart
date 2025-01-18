import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hamikdash_sheli/app_globals.dart';
import 'package:hamikdash_sheli/app_persistence.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/cal/cal_loader.dart';
import 'package:hamikdash_sheli/dataTypes/user.dart';
import 'package:hamikdash_sheli/korbanot_config_files_loader.dart';
import 'package:hamikdash_sheli/pages/welcome_page.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_10y.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  CalLoader().loadAsset();
  KorbanotConfigFilesLoader().load();
  await appPersistence.load();

  tz.initializeTimeZones();
  app_globals.jerusalem = tz.getLocation('Asia/Jerusalem');
  
  appState.user = User(name: "meir", email:"a@b.com");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('he', 'IL'), // Israeli Hebrew
        Locale('en', 'US'), // American English
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'בית הבחירה',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

