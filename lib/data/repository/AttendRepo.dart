import 'package:attend_recorder/data/sheetUtils/SheetPref.dart';
import 'package:gsheets/gsheets.dart';

import '../../domain/models/User.dart';
import '../../domain/repository/AttendanceRepo.dart';
import '../sheetUtils/AttendSheetApi.dart';

class AttendRepoImpl extends AttendRepository {
  AttendRepoImpl(this._sheetPrefs) {
    _init();
  }

  _init() async {
    _attendSheetApi = await AttendSheetApi.create(_sheetPrefs.sheetId);
    _attendSheetApi!.setSheetLabel(_sheetPrefs.workSheetLabel);
  }

  final SheetPrefs _sheetPrefs;
  late AttendSheetApi? _attendSheetApi;

  AttendSheetApi get _safeAttendSheet {
    if (_attendSheetApi == null)
      throw Exception("Please add sheet id in settings");
    return _attendSheetApi!;
  }

  //pref
  @override
  setSheetId(String? sheetId) async {
    _sheetPrefs.saveSheetId(sheetId);
    setWorkSheetLabel(null);
    try {
      _attendSheetApi = await AttendSheetApi.create(sheetId);
    } on GSheetsException {
      return Future.value("Permission denied");
    }
  }

  @override
  setWorkSheetLabel(String? workSheetLabel) async {
    _sheetPrefs.saveWorkSheetLabel(workSheetLabel);
    _attendSheetApi!.setSheetLabel(workSheetLabel);
  }

  @override
  String? get sheetId => _sheetPrefs.sheetId;

  @override
  String? get workSheetLabel => _sheetPrefs.workSheetLabel;

  //sheet api
  @override
  List<String> get allWorkSheets => _safeAttendSheet.allWorkSheets;

  @override
  Future<List<String>> getAttenders() async => _safeAttendSheet.getAttenders();

  @override
  Future<List<AttenderState>> getAttendersState(DateTime day) async =>
      _safeAttendSheet.getAttendersState(day);

  @override
  addAttender(String user) async => _safeAttendSheet.addAttender(user);

  @override
  removeAttender(String user) async => _safeAttendSheet.removeAttender(user);

  @override
  setState(AttenderState user, DateTime day) async =>
      _safeAttendSheet.setState(user, day);
}
