import 'package:attend_recorder/domain/models/User.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:flutter/material.dart';

import '../../di/DIModule.dart';
import '../../domain/useCase/attendUseCase/GetAllAttendStateUseCase.dart';
import '../../domain/useCase/attendUseCase/SetAttendStateUseCase.dart';
import 'AttenderWidget.dart';

class AttendScreen extends StatefulWidget {
  const AttendScreen({super.key});

  @override
  State<AttendScreen> createState() => _AttendScreenState();
}

class _AttendScreenState extends State<AttendScreen> {
  GetAllAttendStateUseCase getAllAttendStateUseCase = getIt();
  SetAttendStateUseCase setAttendStateUseCase = getIt();

  ResultWrapper<List<AttenderState>> users = ResultWrapper.idle();
  bool _isLoading = false;
  DateTime? selectedDay;

  Future<void> getAttendersState(DateTime selectedDate) async {
    setState(() {
      _isLoading = true;
    });
    users = await getAllAttendStateUseCase.execute(selectedDate);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> changeAttenderState(AttenderState attenderState) async {
    setState(() {
      _isLoading = true;
    });
    await setAttendStateUseCase.execute(attenderState, selectedDay!);
    users = await getAllAttendStateUseCase.execute(selectedDay!);
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
    if (selectedDay != null) {
      getAttendersState(selectedDay!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a day"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Placeholder(),
      );
    } else {
      return Scaffold(
        body: users.when(
            success: (users) => RefreshIndicator(
                  onRefresh: () => getAttendersState(selectedDay!),
                  child: ListView.builder(
                    itemBuilder: (cxt, index) => AttenderWidget(
                      user: users![index],
                      onClick: () => changeAttenderState(users[index]),
                    ),
                    itemCount: users?.length,
                  ),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (error) => Center(
                  child: Column(
                    children: [
                      Text(error.toString()),
                      ElevatedButton(
                          onPressed: () => getAttendersState(selectedDay!),
                          child: const Text("Retry"))
                    ],
                  ),
                )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: selectDate,
          label: const Text("Select Date"),
        ),
      );
    }
  }
}
