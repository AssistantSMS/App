import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'components/adaptive/appShell.dart';
import 'components/bottomNavbar.dart';
import 'env/appRouter.dart';
import 'env/environmentSettings.dart';
import 'integration/dependencyInjection.dart';
import 'integration/router.dart';
import 'state/createStore.dart';
import 'state/modules/base/appState.dart';
import 'state/modules/base/appViewModel.dart';

class MyApp extends StatefulWidget {
  final EnvironmentSettings _env;
  MyApp(this._env);

  @override
  _MyAppState createState() => _MyAppState(this._env);
}

class _MyAppState extends State<MyApp> {
  final EnvironmentSettings _env;
  Store<AppState> store;
  TranslationsDelegate _newLocaleDelegate;

  _MyAppState(this._env) {
    AppRouter.router = CustomRouter.configureRoutes();
    initDependencyInjection(this._env);
    initReduxState();
    if (kReleaseMode) {
      // initFirebaseAdMob();
      // initFirebaseAnalytics();
      // initFirebaseMessaging();
    }

    if (_newLocaleDelegate == null) {
      _newLocaleDelegate = TranslationsDelegate(newLocale: null);
    }
  }

  Future<AppState> initReduxState() async {
    var tempStore = await createStore();
    setState(() {
      store = tempStore;
    });
    if (tempStore != null &&
        tempStore.state != null &&
        tempStore.state.settingState != null &&
        tempStore.state.settingState.selectedLanguage != null) {
      _newLocaleDelegate = TranslationsDelegate(
        newLocale: Locale(tempStore.state.settingState.selectedLanguage),
      );
      return tempStore.state;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (store == null) {
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: getLoading().loadingIndicator()),
        ),
      );
    }

    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, AppViewModel>(
        converter: (store) => AppViewModel.fromStore(store),
        builder: (_, viewModel) => AdaptiveAppShell(
          newLocaleDelegate: TranslationsDelegate(
            newLocale: Locale(viewModel.selectedLanguage),
          ),
        ),
      ),
    );
  }
}
