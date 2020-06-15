import '../../contracts/results/result.dart';
import '../../contracts/results/resultWithValue.dart';

class ILocalStorageService {
  Future<Result> saveToStorage<T>(String key, T state) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<T>> loadFromStorage<T>(String key) async =>
      ResultWithValue<T>(false, null, 'Not Implemented');
}
