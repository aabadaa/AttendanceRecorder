import 'package:hive_flutter/adapters.dart';

class SheetPrefs {
  static const boxName = 'sheet id and labels';
  static const sheetIdKey = "sheet id key";
  static const workSheetKey = "work sheet key";

  final Box<String> _prefs = Hive.box(boxName);

  static init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(boxName);
  }

  saveSheetId(String? sheetId) async {
    if (sheetId != null) {
      _prefs.put(sheetIdKey, sheetId);
    } else {
      _prefs.delete(sheetIdKey);
    }
  }

  saveWorkSheetLabel(String? workSheetLabel) async {
    if (workSheetLabel != null) {
      _prefs.put(workSheetKey, workSheetLabel);
    } else {
      _prefs.delete(workSheetKey);
    }
  }

  String? get sheetId {
    return _prefs.get(sheetIdKey, defaultValue: '');
  }

  String? get workSheetLabel {
    return _prefs.get(workSheetKey, defaultValue: '');
  }
}
