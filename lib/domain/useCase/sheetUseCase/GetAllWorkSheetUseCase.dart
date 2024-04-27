import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

class GetAllWorkSheetUseCase {
  GetAllWorkSheetUseCase(this.attendRepository);

  final AttendRepository attendRepository;

  ResultWrapper<List<String>> execute() => attendRepository.allWorkSheets;
}
