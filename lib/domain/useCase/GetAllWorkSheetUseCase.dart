import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';

class GetAllWorkSheetUseCase {
  GetAllWorkSheetUseCase(this.attendRepository);

  final AttendRepository attendRepository;

  List<String> execute() => attendRepository.allWorkSheets;
}
