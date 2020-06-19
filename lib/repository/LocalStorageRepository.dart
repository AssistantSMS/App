import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import './interface/ILocalStorageRepository.dart';
import '../contracts/results/result.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/logging.dart';

class LocalStorageRepository implements ILocalStorageRepository {
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
  Future<ResultWithValue<Map<String, dynamic>>> loadFromStorage(
      String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var stateString = preferences.getString(key);
      Map<String, dynamic> stateMap = Map<String, dynamic>();
      if (stateString != null) {
        stateMap = json.decode(stateString) as Map<String, dynamic>;
      }
      return ResultWithValue<Map<String, dynamic>>(true, stateMap, '');
    } catch (exception) {
      logger.e(exception, 'loadFromStorage');
      return ResultWithValue<Map<String, dynamic>>(
          false, null, exception.toString());
    }
  }
}
