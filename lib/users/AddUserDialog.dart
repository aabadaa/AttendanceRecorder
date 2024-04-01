import 'package:attend_recorder/DIModule.dart';
import 'package:attend_recorder/sheetUtils/AttendRepo.dart';
import 'package:flutter/material.dart';

import '../models/User.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key, required this.onAdd});

  final void Function(User) onAdd;

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final userNameController = TextEditingController();
  bool _isLoading = false;
  late AttendRepo attendRepo;

  @override
  void initState() {
    attendRepo = getIt();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  Future _addUser(User user) async {
    setState(() {
      _isLoading = true;
    });
    await attendRepo.addAttender(user);
    widget.onAdd(user);
    Navigator.of(context, rootNavigator: true).pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0x00000000),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: !_isLoading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: userNameController,
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => {
                            _addUser(User(name: userNameController.text)),
                          },
                          child: const Text("Add"),
                        ),
                        TextButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context),
                            child: const Text("Cancel"))
                      ],
                    )
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
