import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:redux/redux.dart';

import '../constants/AppConfig.dart';
import 'appReducer.dart';
import 'middleware/localStorageMiddleware.dart';
import 'modules/base/appState.dart';

Future<Store<AppState>> createStore() async {
  AppState stateObj = AppState.initial();
  try {
    ResultWithValue<Map<String, dynamic>> tempResult =
        await getStorageRepo().loadFromStorage(AppConfig.appStateKey);
    if (tempResult.isSuccess) {
      stateObj = AppState.fromJson(tempResult.value);
    }
  } catch (exception) {
    getLog().e(exception.toString());
  }

  return Store(
    appReducer,
    initialState: stateObj,
    middleware: [
      LocalStorageMiddleware(),
    ],
  );
}
