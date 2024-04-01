import 'package:attend_recorder/home/settings/SettingProvider.dart';
import 'package:attend_recorder/sheetUtils/AttendRepo.dart';
import 'package:attend_recorder/sheetUtils/SheetPref.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setup() async {
  print("test");
  getIt.registerSingleton(SheetPrefs());
  print("test 1");
  getIt.registerSingleton<AttendRepo>(AttendRepo(getIt()));
  print("teset 2");
  getIt.registerFactory(() => SettingProvider(getIt()));
  print("teset 3");
}
