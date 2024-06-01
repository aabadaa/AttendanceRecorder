import 'dart:async';

import 'package:attend_recorder/domain/useCase/sheetUseCase/GetAllWorkSheetUseCase.dart';
import 'package:attend_recorder/domain/useCase/sheetUseCase/GetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/sheetUseCase/GetWorkSheetLabelUseCase.dart';
import 'package:attend_recorder/domain/useCase/sheetUseCase/SetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/sheetUseCase/SetWorkSheetLabelUseCase.dart';
import 'package:attend_recorder/domain/utils/ResultWrapper.dart';
import 'package:flutter/material.dart';

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

  ResultWrapper<String> get sheetId => _getSheetIdUseCase.execute();

  ResultWrapper<String> get workLabel => _getWorkSheetLabelUseCase.execute();

  List<String> _workLabels = List.empty();

  List<String> get workLabels => _workLabels;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late Exception errorState;

  setSheetId(String sheetId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _setSheetIdUseCase.execute(sheetId);
      _workLabels = _getAllWorkSheetUseCase.execute().when(
            success: (data) => data ?? List.empty(),
          )!;
    } catch (e, stacktrace) {
      print(stacktrace);
      errorState = e as Exception;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
