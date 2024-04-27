import '../../repository/AttendanceRepo.dart';

class SetSheetIdUseCase {
  SetSheetIdUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<void> execute(String sheetId) => attendRepo.setSheetId(sheetId);
}
