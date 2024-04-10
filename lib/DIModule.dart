import 'package:attend_recorder/domain/repository/AttendanceRepo.dart';
import 'package:attend_recorder/domain/useCase/GetAllAttendersUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetAllWorkSheetUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetAttenderLogUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/GetWorkSheetLabelUseCase.dart';
import 'package:attend_recorder/domain/useCase/RemoeAttenderUseCase.dart';
import 'package:attend_recorder/domain/useCase/SetAttendStateUseCase.dart';
import 'package:attend_recorder/domain/useCase/SetSheetIdUseCase.dart';
import 'package:attend_recorder/domain/useCase/SetWorkSheetLabelUseCase.dart';
import 'package:attend_recorder/presentation/settings/SettingProvider.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/AttendRepo.dart';
import 'data/sheetUtils/SheetPref.dart';
import 'domain/useCase/AddAttenderUseCase.dart';
import 'domain/useCase/GetAllAttendStateUseCase.dart';

final getIt = GetIt.instance;

setup() async {
  getIt.registerSingleton(SheetPrefs());
  getIt.registerSingleton<AttendRepository>(AttendRepoImpl(getIt()));
  getIt.registerSingleton(AddAttenderUseCase(getIt()));
  getIt.registerSingleton(GetAllAttendStateUseCase(getIt()));
  getIt.registerSingleton(GetAllAttendersUseCase(getIt()));
  getIt.registerSingleton(GetAllWorkSheetUseCase(getIt()));
  getIt.registerSingleton(GetAttenderLogUseCase(getIt()));
  getIt.registerSingleton(GetSheetIdUseCase(getIt()));
  getIt.registerSingleton(GetWorkSheetLabelUseCase(getIt()));
  getIt.registerSingleton(RemoveAttenderUseCase(getIt()));
  getIt.registerSingleton(SetAttendStateUseCase(getIt()));
  getIt.registerSingleton(SetSheetIdUseCase(getIt()));
  getIt.registerSingleton(SetWorkSheetLabelUseCase(getIt()));

  getIt.registerFactory(() => SettingProvider(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ));
}
