import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';

class GetSheetIdUseCase {
  GetSheetIdUseCase(this.attendRepository);

  final AttendRepository attendRepository;

  String? execute() => attendRepository.sheetId;
}
