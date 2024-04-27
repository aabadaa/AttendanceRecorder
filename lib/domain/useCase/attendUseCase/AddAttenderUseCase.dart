import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

class AddAttenderUseCase {
  AddAttenderUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<ResultWrapper<void>> execute(String attender) =>
      attendRepo.addAttender(attender);
}
