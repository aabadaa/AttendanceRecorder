import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:attend_recorder/presentation/users/AttendStateCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AddUserDialog.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AttendStateCubit(),
      child: BlocBuilder<AttendStateCubit, ResultWrapper>(
        builder: (context, state) => Scaffold(
          body: state.when(
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              success: (users) => ListView.builder(
                    itemBuilder: (_, index) => TextButton(
                      child: Text(users[index].name),
                      onPressed: () =>
                          {_onUserClicked(context, users[index].name)},
                    ),
                    itemCount: users.length,
                  )),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => {
              showDialog(
                  context: context,
                  builder: (ctx) => AddUserDialog(
                        onAdd: (user) =>
                            {context.read<AttendStateCubit>().getUsers()},
                      ))
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void _onUserClicked(BuildContext context, String user) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: Text("Remove: $user"),
        actions: [
          ElevatedButton(
            onPressed: () {
              context
                  .read<AttendStateCubit>()
                  .removeAttenderUseCase
                  .execute(user);
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
}
