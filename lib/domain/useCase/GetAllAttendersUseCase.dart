import '../repository/AttendanceRepo.dart';

class GetAllAttendersUseCase {
  GetAllAttendersUseCase(this.attendRepo);

  final AttendRepository attendRepo;

  Future<List<String>> execute() => attendRepo.getAttenders();
}
