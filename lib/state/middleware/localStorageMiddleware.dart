import 'dart:convert';

import 'package:redux/redux.dart';

import '../../constants/AppConfig.dart';
import '../../contracts/results/result.dart';
import '../../integration/dependencyInjection.dart';
import '../../integration/logging.dart';
import '../modules/base/appState.dart';
import '../modules/base/persistToStorage.dart';

class LocalStorageMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is PersistToStorage) {
      logger.i('saving to localStorage');
      getStorageService()
          .saveToStorage(
        AppConfig.appStateKey,
        json.encode(store.state.toJson()),
      )
          .then((Result saveResult) {
        if (saveResult.isSuccess) return;
        logger.e(saveResult.errorMessage);
      });
    }
  }
}
