import '../repository/AttendanceRepo.dart';

class RemoveAttenderUseCase {
  RemoveAttenderUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<void> execute(String attender) => attendRepo.removeAttender(attender);
}
