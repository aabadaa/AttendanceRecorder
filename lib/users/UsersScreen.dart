import 'package:attend_recorder/users/AddUserDialog.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';
import '../sheetUtils/AttendSheetApi.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> users = List.empty();

  bool _isLoading = false;

  Future<void> getUsers() async {
    setState(() {
      _isLoading = true;
    });
    users = await AttendSheetApi.getAttenders().then(
        (value) => Future.value(value.map((e) => User(name: e)).toList()));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void _onUserClicked(User user) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: Text("Remove: ${user.name}"),
        actions: [
          ElevatedButton(
            onPressed: () {
              AttendSheetApi.removeAttender(user);
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
                onPressed: () => {_onUserClicked(users[index])},
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
