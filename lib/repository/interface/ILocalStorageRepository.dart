import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class ILocalStorageRepository {
  Future<Result> saveToStorage(String key, String stateJson) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<Map<String, dynamic>>> loadFromStorage(
          String key) async =>
      ResultWithValue<Map<String, dynamic>>(false, null, 'Not Implemented');
}
