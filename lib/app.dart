import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'components/adaptive/appShell.dart';
import 'env/appRouter.dart';
import 'env/environmentSettings.dart';
import 'integration/dependencyInjection.dart';
import 'integration/router.dart';
import 'state/createStore.dart';
import 'state/modules/base/appState.dart';
import 'state/modules/base/appViewModel.dart';

class AssistantSMS extends StatefulWidget {
  final EnvironmentSettings _env;
  const AssistantSMS(this._env, {Key key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _AssistantSMSState createState() => _AssistantSMSState(_env);
}

class _AssistantSMSState extends State<AssistantSMS> {
  Store<AppState> store;

  _AssistantSMSState(EnvironmentSettings env) {
    AppRouter.router = CustomRouter.configureRoutes();
    initDependencyInjection(env);
    initReduxState();
    if (kReleaseMode) {
      // initFirebaseAdMob();
      // initFirebaseAnalytics();
      // initFirebaseMessaging();
    }
  }

  Future<AppState> initReduxState() async {
    Store<AppState> tempStore = await createStore();
    setState(() {
      store = tempStore;
    });
    if (tempStore != null &&
        tempStore.state != null &&
        tempStore.state.settingState != null &&
        tempStore.state.settingState.selectedLanguage != null) {
      return tempStore.state;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (store == null) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: Text('Something went wrong')),
        ),
      );
    }

    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, AppViewModel>(
        converter: (store) => AppViewModel.fromStore(store),
        builder: (_, viewModel) => AdaptiveAppShell(
          key: Key(viewModel.selectedLanguage),
          newLocaleDelegate: TranslationsDelegate(
            newLocale: Locale(viewModel.selectedLanguage),
          ),
        ),
      ),
    );
  }
}
