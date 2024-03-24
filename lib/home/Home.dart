import 'package:attend_recorder/home/AttendScreen.dart';
import 'package:attend_recorder/users/UsersScreen.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  var _selectedIndex = 0;

  final options = const [AttendScreen(), UsersScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who Attends today?"),
      ),
      body: options[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Users"),
        ],
        onTap: onIndexChanged,
      ),
    );
  }

  void onIndexChanged(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
