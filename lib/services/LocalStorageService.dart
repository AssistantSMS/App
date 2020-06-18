import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import './interface/ILocalStorageService.dart';
import '../contracts/results/result.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/logging.dart';

class LocalStorageService implements ILocalStorageService {
  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, stateString);
      return Result(true, '');
    } catch (exception) {
      logger.e(exception);
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<T>> loadFromStorage<T>(
      String key, T Function(dynamic) mapper) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var stateString = preferences.getString(key);
      Map<String, dynamic> stateMap = Map<String, dynamic>();
      if (stateString != null) {
        stateMap = json.decode(stateString) as Map<String, dynamic>;
      }
      return ResultWithValue<T>(true, mapper(stateMap), '');
    } catch (exception) {
      logger.e(exception, 'loadFromStorage');
      return ResultWithValue<T>(false, null, exception.toString());
    }
  }
}
