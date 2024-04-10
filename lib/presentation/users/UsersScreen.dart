import 'package:attend_recorder/DIModule.dart';
import 'package:attend_recorder/domain/useCase/GetAllAttendersUseCase.dart';
import 'package:attend_recorder/domain/useCase/RemoeAttenderUseCase.dart';
import 'package:flutter/material.dart';

import '../../domain/models/User.dart';
import 'AddUserDialog.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<AttenderState> users = List.empty();
  bool _isLoading = false;
  late RemoveAttenderUseCase removeAttenderUseCase;
  late GetAllAttendersUseCase getAllAttendersUseCase;

  Future<void> getUsers() async {
    setState(() {
      _isLoading = true;
    });
    users = await getAllAttendersUseCase.execute().then((value) =>
        Future.value(value.map((e) => AttenderState(name: e)).toList()));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllAttendersUseCase = getIt();
    removeAttenderUseCase = getIt();
    getUsers();
  }

  void _onUserClicked(String user) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: Text("Remove: $user"),
        actions: [
          ElevatedButton(
            onPressed: () {
              removeAttenderUseCase.execute(user);
              Navigator.of(cxt).pop();
            },
            child: const Text("Delete"),
          ),
          TextButton(
              onPressed: () => Navigator.of(cxt).pop(),
              child: const Text("Cancel"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (_, index) => TextButton(
                child: Text(users[index].name),
                onPressed: () => {_onUserClicked(users[index].name)},
              ),
              itemCount: users.length,
            ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (ctx) => AddUserDialog(
                    onAdd: (user) => {getUsers()},
                  ))
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
