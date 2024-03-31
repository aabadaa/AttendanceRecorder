import 'dart:async';

import 'package:attend_recorder/sheetUtils/AttendSheetApi.dart';
import 'package:attend_recorder/sheetUtils/SheetPref.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider(this.box);

  final SheetPrefs box;

  String? get sheetId => box.sheetId;

  String? get workLabel => box.workSheetLabel;

  List<String> _workLabels = List.empty();

  List<String> get workLabels => _workLabels;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String> setSheetId(String sheetId) async {
    _isLoading = true;
    notifyListeners();
    box.saveSheetId(sheetId);
    box.saveWorkSheetLabel(null);
    try {
      await AttendSheetApi.init(spreadSheetId: sheetId);
    } on GSheetsException {
      _isLoading = false;
      notifyListeners();
      return Future.value("Permission denied");
    }
    _workLabels = AttendSheetApi.allWorkSheets;
    _isLoading = false;
    notifyListeners();
    return Future.value("Done");
  }

  Future<String> setSheetLabel(String sheetLabel) async {
    _isLoading = true;
    notifyListeners();

    box.saveWorkSheetLabel(sheetLabel);

    _isLoading = false;
    notifyListeners();
    return Future(() => "Done");
  }
}
