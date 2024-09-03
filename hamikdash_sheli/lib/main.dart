import 'package:flutter/material.dart';
import 'package:hamikdash_sheli/cal/cal_loader.dart';
import 'package:hamikdash_sheli/pages/welcome_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CalLoader().loadAsset();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

