import 'package:attend_recorder/domain/models/User.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';

import '../repository/AttendanceRepo.dart';

class GetAllAttendStateUseCase {
  GetAllAttendStateUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<ResultWrapper<List<AttenderState>>> execute(DateTime day) =>
      attendRepo.getAttendersState(day);
}
