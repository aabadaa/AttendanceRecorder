import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

class GetSheetIdUseCase {
  GetSheetIdUseCase(this.attendRepository);

  final AttendRepository attendRepository;

  ResultWrapper<String> execute() => attendRepository.sheetId;
}
