import 'package:attend_recorder/sheetUtils/AttendSheetApi.dart';
import 'package:attend_recorder/sheetUtils/SheetPref.dart';
import 'package:gsheets/gsheets.dart';

import '../models/User.dart';

class AttendRepo {
  AttendRepo(this._sheetPrefs) {
    _init();
  }

  _init() async {
    _attendSheetApi = await AttendSheetApi.create(_sheetPrefs.sheetId);
    _attendSheetApi!.setSheetLabel(_sheetPrefs.workSheetLabel);
  }

  final SheetPrefs _sheetPrefs;
  late AttendSheetApi? _attendSheetApi;

  AttendSheetApi get safeAttend {
    if (_attendSheetApi == null)
      throw Exception("Please add sheet id in settings");
    return _attendSheetApi!;
  }

  //pref
  saveSheetId(String? sheetId) async {
    _sheetPrefs.saveSheetId(sheetId);
    saveWorkSheetLabel(null);
    try {
      _attendSheetApi = await AttendSheetApi.create(sheetId);
    } on GSheetsException {
      return Future.value("Permission denied");
    }
  }

  saveWorkSheetLabel(String? workSheetLabel) async {
    _sheetPrefs.saveWorkSheetLabel(workSheetLabel);
    _attendSheetApi!.setSheetLabel(workSheetLabel);
  }

  String? get sheetId => _sheetPrefs.sheetId;

  String? get workSheetLabel => _sheetPrefs.workSheetLabel;

  //sheet api
  List<String> get allWorkSheets => safeAttend.allWorkSheets;

  Future<List<String>> getAttenders() async => safeAttend.getAttenders();

  Future<List<User>> getAttendersState(DateTime day) async =>
      safeAttend.getAttendersState(day);

  addAttender(User user) async => safeAttend.addAttender(user);

  removeAttender(User user) async => safeAttend.removeAttender(user);

  setState(User user, DateTime day) async => safeAttend.setState(user, day);
}
