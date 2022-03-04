import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../constants/AppConfig.dart';
import '../integration/dependencyInjection.dart';
import '../repository/interface/ILocalStorageRepository.dart';
import '../state/modules/base/appState.dart';
import '../state/themeState.dart';
import 'json/interface/ILocalStorageService.dart';

class LocalStorageService implements ILocalStorageService {
  ILocalStorageRepository _storageRepo;

  LocalStorageService() {
    _storageRepo = getStorageRepo();
  }

  @override
  Future<Result> saveAppState(AppState state) {
    return _storageRepo.saveToStorage(
      AppConfig.appStateKey,
      json.encode(state.toJson()),
    );
  }

  @override
  Future<ResultWithValue<AppState>> loadAppState() async {
    ResultWithValue<Map<String, dynamic>> tempResult =
        await _storageRepo.loadFromStorage(AppConfig.appStateKey);

    if (!tempResult.isSuccess) {
      return ResultWithValue<AppState>(false, null, tempResult.errorMessage);
    }
    try {
      AppState result = AppState.fromJson(tempResult.value);
      return ResultWithValue<AppState>(true, result, '');
    } catch (exception) {
      getLog().e('localStorageService - loadAppState: ' + exception.toString());
      return ResultWithValue<AppState>(false, null, exception.errorMessage);
    }
  }

  @override
  Future<Result> saveThemeState(ThemeState state) {
    return _storageRepo.saveToStorage(
      AppConfig.themeKey,
      json.encode(state.toJson()),
    );
  }

  @override
  Future<ResultWithValue<ThemeState>> loadThemeState() async {
    ResultWithValue<Map<String, dynamic>> tempResult =
        await _storageRepo.loadFromStorage(AppConfig.themeKey);

    if (!tempResult.isSuccess) {
      return ResultWithValue<ThemeState>(false, null, tempResult.errorMessage);
    }
    try {
      ThemeState result = ThemeState.fromJson(tempResult.value);
      return ResultWithValue<ThemeState>(true, result, '');
    } catch (exception) {
      return ResultWithValue<ThemeState>(false, null, exception.errorMessage);
    }
  }
}
