import 'package:attend_recorder/domain/models/User.dart';

import '../repository/AttendanceRepo.dart';

class SetAttendStateUseCase {
  SetAttendStateUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<void> execute(AttenderState attendState, DateTime day) =>
      attendRepo.setState(attendState, day);
}
