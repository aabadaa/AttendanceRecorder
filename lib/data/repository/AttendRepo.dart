import 'package:attend_recorder/data/sheetUtils/SheetPref.dart';
import 'package:attend_recorder/domain/exception/NotProvidedSheetIdException.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
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
    _attendSheetApi?.setSheetLabel(_sheetPrefs.workSheetLabel);
  }

  final SheetPrefs _sheetPrefs;
  late AttendSheetApi? _attendSheetApi;

  AttendSheetApi get _safeAttendSheet {
    if (_attendSheetApi == null) {
      throw Exception("Please add sheet id in settings");
    }
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
  ResultWrapper<String> get sheetId {
    try {
      final out = _sheetPrefs.sheetId;
      if (out == null) {
        return ResultWrapper.error(NotProvidedSheetIdException());
      }
      return ResultWrapper.success(out);
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  @override
  ResultWrapper<String> get workSheetLabel {
    try {
      final out = _sheetPrefs.workSheetLabel;
      if (out == null) {
        return ResultWrapper.error(NotProvidedWorkSheetLabelException());
      }
      return ResultWrapper.success(out);
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  //sheet api
  @override
  ResultWrapper<List<String>> get allWorkSheets {
    try {
      final out = _safeAttendSheet.allWorkSheets;
      return ResultWrapper.success(out);
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  @override
  Future<ResultWrapper<List<String>>> getAttenders() async {
    try {
      final out = await _safeAttendSheet.getAttenders();
      return ResultWrapper.success(out);
    } catch (e) {
      return ResultWrapper.error(e);
    }
  }

  @override
  Future<ResultWrapper<List<AttenderState>>> getAttendersState(
      DateTime day) async {
    try {
      final out = await _safeAttendSheet.getAttendersState(day);
      return ResultWrapper.success(out);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return ResultWrapper.error(e);
    }
  }

  @override
  addAttender(String user) async {
    try {
      await _safeAttendSheet.addAttender(user);
      return Future(() => ResultWrapper.success(null));
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Future(() => ResultWrapper.error(e));
    }
  }

  @override
  removeAttender(String user) async {
    try {
      _safeAttendSheet.removeAttender(user);
      return Future.value(ResultWrapper.success(null));
    } catch (e) {
      print(e);
      return Future(() => ResultWrapper.error(e));
    }
  }

  @override
  setState(AttenderState user, DateTime day) async {
    try {
      _safeAttendSheet.setState(user, day);
      return Future.value(ResultWrapper.success(null));
    } catch (e) {
      print(e);
      return Future(() => ResultWrapper.error(e));
    }
  }
}
