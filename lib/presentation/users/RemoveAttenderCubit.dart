import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/DIModule.dart';
import '../../domain/useCase/attendUseCase/RemoveAttenderUseCase.dart';
import '../../domain/utils/ResultWrapper.dart';

class RemoveAttenderCubit extends Cubit<ResultWrapper<void>> {
  RemoveAttenderCubit() : super(ResultWrapper.idle());

  RemoveAttenderUseCase removeAttenderUseCase = getIt();

  Future<void> removeAttender(String attenderName) async {
    emit(ResultWrapper.loading());
    emit((await removeAttenderUseCase.execute(attenderName)));
  }
}
