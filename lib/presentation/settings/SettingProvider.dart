import 'dart:async';

import 'package:attend_recorder/domain/useCase/GetAllWorkSheetUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetWorkSheetLabelUseCase.dart';
import 'package:attend_recorder/domain/useCase/SetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/SetWorkSheetLabelUseCase.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

class SettingProvider with ChangeNotifier {
  SettingProvider(
    this._getSheetIdUseCase,
    this._getWorkSheetLabelUseCase,
    this._getAllWorkSheetUseCase,
    this._setSheetIdUseCase,
    this._setWorkSheetLabelUseCase,
  );

  final GetSheetIdUseCase _getSheetIdUseCase;
  final GetWorkSheetLabelUseCase _getWorkSheetLabelUseCase;
  final GetAllWorkSheetUseCase _getAllWorkSheetUseCase;
  final SetSheetIdUseCase _setSheetIdUseCase;
  final SetWorkSheetLabelUseCase _setWorkSheetLabelUseCase;

  String? get sheetId => _getSheetIdUseCase.execute();

  String? get workLabel => _getWorkSheetLabelUseCase.execute();

  List<String> _workLabels = List.empty();

  List<String> get workLabels => _workLabels;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String> setSheetId(String sheetId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _setSheetIdUseCase.execute(sheetId);
    } on GSheetsException {
      _isLoading = false;
      notifyListeners();
      return Future.value("Permission denied");
    }
    _workLabels = _getAllWorkSheetUseCase.execute();
    _isLoading = false;
    notifyListeners();
    return Future.value("Done");
  }

  Future<String> setSheetLabel(String sheetLabel) async {
    _isLoading = true;
    notifyListeners();
    await _setWorkSheetLabelUseCase.execute(sheetLabel);
    _isLoading = false;
    notifyListeners();
    return Future(() => "Done");
  }
}
