import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';

class GetWorkSheetLabelUseCase {
  GetWorkSheetLabelUseCase(this.attendRepository);

  final AttendRepository attendRepository;

  String? execute() => attendRepository.workSheetLabel;
}
