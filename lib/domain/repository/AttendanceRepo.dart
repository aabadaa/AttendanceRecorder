import '../models/User.dart';

abstract class AttendRepository {
  Future<void> setSheetId(String? sheetId);

  Future<void> setWorkSheetLabel(String? workSheetLabel);

  String? get sheetId;

  String? get workSheetLabel;

  List<String> get allWorkSheets;

  Future<List<String>> getAttenders();

  Future<List<AttenderState>> getAttendersState(DateTime day);

  Future<void> addAttender(String user);

  Future<void> removeAttender(String user);

  Future<void> setState(AttenderState user, DateTime day);
}
