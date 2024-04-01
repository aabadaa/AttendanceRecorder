import 'package:attend_recorder/models/User.dart';
import 'package:gsheets/gsheets.dart';

import '../sheetUtils/Credentials.dart';
import '../utils.dart';

class AttendSheetApi {
  static final _gSheet = GSheets(credentials);
  Worksheet? _attendSheet;
  final Spreadsheet spreadSheet;

  static Future<AttendSheetApi?> create(String? spreadSheetId) async {
    if (spreadSheetId == null) return Future.value(null);
    final spreadSheet = await _gSheet.spreadsheet(spreadSheetId);
    return Future(() => AttendSheetApi._(spreadSheet));
  }

  AttendSheetApi._(this.spreadSheet);

  setSheetLabel(String? sheetLabel) {
    print("Hello set sheeet label");
    if (sheetLabel != null) {
      _attendSheet = spreadSheet.worksheetByTitle(sheetLabel);
      print("Sed is done");
    }
  }

  List<String> get allWorkSheets =>
      spreadSheet.sheets.map((e) => e.title).toList();

  Future<List<String>> getAttenders() async {
    // await cleanTable();
    return _attendSheet!.values.row(1).then((list) {
      if (list.isNotEmpty) list.removeAt(0);
      return Future.value(list);
    });
  }

  Future<List<User>> getAttendersState(DateTime dateTime) async {
    print("getAttendersState");
    final allDates = await _attendSheet!.values.column(1).then((value) {
      value.removeAt(0);
      return Future.value(value
          .map((e) => getDateFromString(e))
          .where((element) => element != null)
          .toList());
    });
    final timeIndex = allDates.indexWhere(
            (e) => getStringFromDate(e!) == getStringFromDate(dateTime)) +
        2; // one for sheet index (starts from 1 instead of 0) and one for the first title cell (date)

    print("timeIndex $timeIndex");

    if (timeIndex <= 1) {
      await _attendSheet!.values.appendRow([getStringFromDate(dateTime)]);
      return getAttendersState(dateTime);
    }
    final users = await getAttenders();
    final List<DateTime?> states = await _attendSheet!.values
        .row(timeIndex, length: users.length)
        .then((list) {
      print("attend row $list");
      list.removeAt(0);
      return Future.value(list.map((e) => getTimeFromString(e)).toList());
    });
    print("states $states\n ${states.length}");
    final out = <User>[];
    for (int i = 0; i < users.length; i++) {
      final userName = users[i];
      final userState = i >= states.length ? null : states[i];
      out.add(User(name: userName, attendDate: userState));
    }
    return Future.value(out);
  }

  Future addAttender(User user) async {
    _attendSheet!.values.appendColumn([user.name]);
  }

  Future removeAttender(User user) async {
    final attenders = await _attendSheet!.values.row(1);
    final attenderIndex = attenders.indexOf(user.name);

    if (attenderIndex < 0) return;

    final lastColumn = await _attendSheet!.cells.lastColumn();
    final userColumn = await _attendSheet!.cells
        .column(attenderIndex + 1, length: lastColumn!.length);

    for (int i = 0; i < lastColumn.length; i++) {
      final lastColumnValue = i >= lastColumn.length ? "" : lastColumn[i].value;
      userColumn[i].post(lastColumnValue);
      lastColumn[i].post("");
    }
  }

  Future setState(User user, DateTime day) async {
    print("setState");
    final userColumn = (await _attendSheet!.values.row(1)).indexOf(user.name);
    final dayRow =
        (await _attendSheet!.values.column(1)).indexOf(getStringFromDate(day));

    if (userColumn < 0 || dayRow < 0) {
      print("negative index $userColumn, $dayRow");
    }
    final newState =
        user.attendDate == null ? getStringFromTime(DateTime.now()) : "";

    final attendCell =
        await _attendSheet!.cells.cell(row: dayRow + 1, column: userColumn + 1);
    attendCell.post(newState);
  }
}
