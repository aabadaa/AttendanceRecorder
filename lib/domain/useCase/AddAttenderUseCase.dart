import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';

class AddAttenderUseCase {
  AddAttenderUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<void> execute(String attender) => attendRepo.addAttender(attender);
}
