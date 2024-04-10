import 'package:attend_recorder/DIModule.dart';
import 'package:attend_recorder/domain/useCase/AddAttenderUseCase.dart';
import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key, required this.onAdd});

  final void Function(String) onAdd;

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final userNameController = TextEditingController();
  bool _isLoading = false;
  late AddAttenderUseCase addAttenderUseCase;

  @override
  void initState() {
    addAttenderUseCase = getIt();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  Future _addUser(String user) async {
    setState(() {
      _isLoading = true;
    });
    await addAttenderUseCase.execute(user);
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
                            _addUser(userNameController.text),
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
