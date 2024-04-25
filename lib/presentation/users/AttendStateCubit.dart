import 'package:attend_recorder/DIModule.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/useCase/GetAllAttendersUseCase.dart';
import '../../domain/useCase/RemoeAttenderUseCase.dart';

class AttendStateCubit extends Cubit<ResultWrapper<List<String>>> {
  AttendStateCubit() : super(ResultWrapper.idle()) {
    getUsers();
  }

  RemoveAttenderUseCase removeAttenderUseCase = getIt();
  GetAllAttendersUseCase getAllAttendersUseCase = getIt();

  Future<void> getUsers() async {
    emit(ResultWrapper.loading());
    emit((await getAllAttendersUseCase.execute()));
  }
}
