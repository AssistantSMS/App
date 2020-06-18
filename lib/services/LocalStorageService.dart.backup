import 'package:hive/hive.dart';

import './interface/ILocalStorageService.dart';
import '../contracts/results/result.dart';
import '../contracts/results/resultWithValue.dart';
import '../integration/logging.dart';

class LocalStorageService implements ILocalStorageService {
  @override
  Future<Result> saveToStorage<T>(String key, T state) async {
    try {
      Box<T> appBox = await Hive.openBox<T>(key);
      appBox.put(key, state);
      appBox.close();
      return Result(true, '');
    } catch (exception) {
      logger.e(exception);
      return Result(false, exception.toString());
    }
  }

  @override
  Future<ResultWithValue<T>> loadFromStorage<T>(String key) async {
    try {
      Box<T> appBox = await Hive.openBox<T>(key);
      T value = appBox.get(key);
      if (value == null) throw Exception('value is empty');
      appBox.close();
      return ResultWithValue<T>(true, value, '');
    } catch (exception) {
      logger.e(exception);
      return ResultWithValue<T>(false, null, exception.toString());
    }
  }
}
