import 'package:attend_recorder/domain/models/User.dart';

import '../repository/AttendanceRepo.dart';

class GetAllAttendStateUseCase {
  GetAllAttendStateUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<List<AttenderState>> execute(DateTime day) =>
      attendRepo.getAttendersState(day);
}
