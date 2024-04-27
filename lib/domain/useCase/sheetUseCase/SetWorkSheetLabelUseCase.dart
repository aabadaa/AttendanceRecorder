import '../../repository/AttendanceRepo.dart';

class SetWorkSheetLabelUseCase {
  SetWorkSheetLabelUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<void> execute(String workSheetLabel) =>
      attendRepo.setWorkSheetLabel(workSheetLabel);
}
