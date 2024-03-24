import 'package:attend_recorder/sheetUtils/AttendSheetApi.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';
import 'UserWidget.dart';

class AttendScreen extends StatefulWidget {
  const AttendScreen({super.key});

  @override
  State<AttendScreen> createState() => _AttendScreenState();
}

class _AttendScreenState extends State<AttendScreen> {
  List<User> users = List.empty();
  bool _isLoading = false;
  DateTime selectedDay = DateTime.now();

  Future<void> getAttendersState(DateTime selectedDate) async {
    setState(() {
      _isLoading = true;
    });
    users = await AttendSheetApi.getAttendersState(selectedDate);
    setState(() {
      _isLoading = false;
    });
  }

  Future selectDate() async {
    final selectedDate = await showDatePicker(
        initialDate: selectedDay,
        firstDate: DateTime(2024, 2, 11),
        lastDate: DateTime.now(),
        context: context);
    selectedDay = selectedDate ?? selectedDay;
    getAttendersState(selectedDay);
  }

  @override
  void initState() {
    super.initState();
    selectDate();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: Placeholder(),
          )
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: () => getAttendersState(selectedDay),
              child: ListView.builder(
                itemBuilder: (cxt, index) => AttenderWidget(
                  user: users[index],
                  onClick: () =>
                      AttendSheetApi.setState(users[index], selectedDay),
                ),
                itemCount: users.length,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: selectDate,
              label: const Text("Select Date"),
            ),
          );
  }
}
