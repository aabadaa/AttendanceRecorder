import 'package:attend_recorder/di/DIModule.dart';
import 'package:attend_recorder/presentation/home/Home.dart';
import 'package:flutter/material.dart';

import '../data/sheetUtils/SheetPref.dart';

Future<void> main() async {
  await SheetPrefs.init();
  await setup();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Who attends',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeWidget(),
    );
  }
}
