import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/app_state.dart';
import 'package:hamikdash_sheli/cal/cal_loader.dart';
import 'package:hamikdash_sheli/dataTypes/user.dart';
import 'package:hamikdash_sheli/pages/welcome_page.dart';

import 'package:timezone/data/latest_10y.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CalLoader().loadAsset();
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

