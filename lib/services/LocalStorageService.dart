import 'dart:convert';

import 'package:scrapmechanic_kurtlourens_com/integration/logging.dart';
import 'package:scrapmechanic_kurtlourens_com/state/themeState.dart';

import './interface/ILocalStorageService.dart';
import '../constants/AppConfig.dart';
import '../contracts/results/result.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/dependencyInjection.dart';
import '../repository/interface/ILocalStorageRepository.dart';
import '../state/modules/base/appState.dart';

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

    if (!tempResult.isSuccess)
      return ResultWithValue<AppState>(false, null, tempResult.errorMessage);
    try {
      AppState result = AppState.fromJson(tempResult.value);
      return ResultWithValue<AppState>(true, result, '');
    } catch (exception) {
      logger.e(exception, 'localStorageService - loadAppState');
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

    if (!tempResult.isSuccess)
      return ResultWithValue<ThemeState>(false, null, tempResult.errorMessage);
    try {
      ThemeState result = ThemeState.fromJson(tempResult.value);
      return ResultWithValue<ThemeState>(true, result, '');
    } catch (exception) {
      return ResultWithValue<ThemeState>(false, null, exception.errorMessage);
    }
  }
}
