import 'dart:async';

import 'package:attend_recorder/sheetUtils/AttendRepo.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider(this.attendRepo);

  final AttendRepo attendRepo;

  String? get sheetId => attendRepo.sheetId;

  String? get workLabel => attendRepo.workSheetLabel;

  List<String> _workLabels = List.empty();

  List<String> get workLabels => _workLabels;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String> setSheetId(String sheetId) async {
    _isLoading = true;
    notifyListeners();
    try {
      attendRepo.saveSheetId(sheetId);
    } on GSheetsException {
      _isLoading = false;
      notifyListeners();
      return Future.value("Permission denied");
    }
    _workLabels = attendRepo.allWorkSheets;
    _isLoading = false;
    notifyListeners();
    return Future.value("Done");
  }

  Future<String> setSheetLabel(String sheetLabel) async {
    _isLoading = true;
    notifyListeners();
    await attendRepo.saveWorkSheetLabel(sheetLabel);
    _isLoading = false;
    notifyListeners();
    return Future(() => "Done");
  }
}
