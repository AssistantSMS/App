import 'dart:convert';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:redux/redux.dart';

import '../../constants/AppConfig.dart';
import '../modules/base/appState.dart';
import '../modules/base/persistToStorage.dart';

class LocalStorageMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is PersistToStorage) {
      getLog().i('saving to localStorage');
      String stateString = json.encode(store.state.toJson());
      getStorageRepo()
          .saveToStorage(AppConfig.appStateKey, stateString)
          .then((Result saveResult) {
        if (saveResult.isSuccess) return;
        getLog().e(saveResult.errorMessage);
      });
    }
  }
}
