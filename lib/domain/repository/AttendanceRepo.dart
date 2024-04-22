import '../models/User.dart';
import '../utils/ResultWrapper.dart';

abstract class AttendRepository {
  Future<void> setSheetId(String? sheetId);

  Future<void> setWorkSheetLabel(String? workSheetLabel);

  ResultWrapper<String> get sheetId;

  ResultWrapper<String> get workSheetLabel;

  ResultWrapper<List<String>> get allWorkSheets;

  Future<ResultWrapper<List<String>>> getAttenders();

  Future<ResultWrapper<List<AttenderState>>> getAttendersState(DateTime day);

  Future<void> addAttender(String user);

  Future<void> removeAttender(String user);

  Future<void> setState(AttenderState user, DateTime day);
}
