import 'package:redux/redux.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/results/resultWithValue.dart';

import './middleware/localStorageMiddleware.dart';
import '../constants/AppConfig.dart';
import '../helpers/deviceHelper.dart';
import '../integration/dependencyInjection.dart';
import '../integration/logging.dart';
import 'appReducer.dart';
import 'modules/base/appState.dart';

Future<Store<AppState>> createStore() async {
  List<void Function(Store<AppState>, dynamic, void Function(dynamic))>
      middlewares =
      List<void Function(Store<AppState>, dynamic, void Function(dynamic))>();
  AppState stateObj = AppState.initial();
  if (isAndroid || isiOS || isWeb) {
    try {
      ResultWithValue<AppState> stateResult =
          await getStorageService().loadAppState();
      if (stateResult.isSuccess) stateObj = stateResult.value;
    } catch (exception) {
      logger.e(exception);
    }
    middlewares.add(LocalStorageMiddleware());
  }

  return Store(
    appReducer,
    initialState: stateObj,
    middleware: middlewares,
  );
}
