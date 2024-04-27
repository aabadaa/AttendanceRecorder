import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:attend_recorder/presentation/users/AttendStateCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AddUserDialog.dart';
import 'RemoveAttenderCubit.dart';

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
                      child: Text(users[index]),
                      onPressed: () => {_onUserClicked(context, users[index])},
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
      builder: (cxt) => BlocProvider(
        create: (_) => RemoveAttenderCubit(),
        child: BlocBuilder<RemoveAttenderCubit, ResultWrapper>(
          builder: (cxt, state) {
            final normalWidget = Text("Remove: $user");
            return AlertDialog(
              title: state.when(
                  idle: () => normalWidget,
                  success: (data) {
                    Future.delayed(
                      const Duration(seconds: 3),
                      () => Navigator.of(cxt).pop(),
                    );
                    return const Text("Done");
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error) => Text(error)),
              actions: state.isSuccess
                  ? []
                  : [
                      ElevatedButton(
                        onPressed: () {
                          cxt.read<RemoveAttenderCubit>().removeAttender(user);
                        },
                        child: Text(!state.isError ? "Delete" : "Retry"),
                      ),
                      TextButton(
                          onPressed: () => Navigator.of(cxt).pop(),
                          child: const Text("Cancel"))
                    ],
            );
          },
        ),
      ),
    ).then((value) => context.read<AttendStateCubit>().getUsers());
  }
}
