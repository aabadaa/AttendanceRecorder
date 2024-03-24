import 'package:attend_recorder/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:attend_recorder/sheetUtils/AttendSheetApi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AttendSheetApi.init();
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
      home: HomeWidget(),
    );
  }
}
