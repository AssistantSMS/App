import '../../contracts/results/result.dart';
import '../../contracts/results/resultWithValue.dart';

class ILocalStorageService {
  Future<Result> saveToStorage(String key, String stateJson) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<T>> loadFromStorage<T>(
          String key, T Function(dynamic) mapper) async =>
      ResultWithValue<T>(false, null, 'Not Implemented');
}
