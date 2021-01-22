import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './interface/ILocalStorageRepository.dart';

class LocalStorageRepository implements ILocalStorageRepository {
  @override
  Future<Result> saveToStorage(String key, String stateString) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(key, stateString);
      return Result(true, '');
    } catch (exception) {
      getLog().e('saveToStorage: ' + exception.toString());
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<Map<String, dynamic>>> loadFromStorage(
      String key) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var stateString = preferences.getString(key);
      if (stateString == null) {
        return ResultWithValue<Map<String, dynamic>>(
            false, null, 'StateString is null');
      }
      Map<String, dynamic> stateMap =
          json.decode(stateString) as Map<String, dynamic>;
      return ResultWithValue<Map<String, dynamic>>(true, stateMap, '');
    } catch (exception) {
      getLog().e('loadFromStorage: ' + exception.toString());
      return ResultWithValue<Map<String, dynamic>>(
          false, null, exception.toString());
    }
  }
}
