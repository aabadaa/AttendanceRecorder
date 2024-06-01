import 'package:attend_recorder/di/DIModule.dart';
import 'package:attend_recorder/domain/useCase/attendUseCase/AddAttenderUseCase.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:flutter/material.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key, required this.onAdd});

  final void Function(String) onAdd;

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final userNameController = TextEditingController();
  var addingUserState = ResultWrapper.idle();
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
      addingUserState = ResultWrapper.loading();
    });

    addingUserState = await addAttenderUseCase.execute(user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0x00000000),
      child: Card(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: addingUserState.when(
              success: (data) {
                Future.delayed(const Duration(seconds: 1), () {
                  widget.onAdd(userNameController.text);
                  Navigator.of(context, rootNavigator: true).pop(context);
                });
                return const Wrap(
                    alignment: WrapAlignment.center, children: [Text("Done")]);
              },
              loading: () => _loadingState(),
              idle: () => _idleState(),
              error: (error) => _errorState(error)),
        ),
      ),
    );
  }

  Widget _idleState() {
    return Column(
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
                    Navigator.of(context, rootNavigator: true).pop(context),
                child: const Text("Cancel"))
          ],
        )
      ],
    );
  }

  Widget _errorState(error) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(error.toString()),
        Row(
          children: [
            OutlinedButton(
              onPressed: () => _addUser(userNameController.text),
              child: const Text("Retry"),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(context),
              child: const Text("Cancel"),
            )
          ],
        )
      ],
    );
  }

  Widget _loadingState() {
    return const Wrap(
      alignment: WrapAlignment.center,
      children: [CircularProgressIndicator()],
    );
  }
}
