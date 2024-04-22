import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

import '../repository/AttendanceRepo.dart';

class GetAllAttendersUseCase {
  GetAllAttendersUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<ResultWrapper<List<String>>> execute() => attendRepo.getAttenders();
}
