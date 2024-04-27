import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

import '../../repository/AttendanceRepo.dart';

class RemoveAttenderUseCase {
  RemoveAttenderUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<ResultWrapper<void>> execute(String attender) =>
      attendRepo.removeAttender(attender);
}
