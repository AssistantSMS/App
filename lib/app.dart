import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'components/adaptive/appShell.dart';
import 'env/environment_settings.dart';
import 'integration/dependencyInjection.dart';
import 'state/createStore.dart';
import 'state/modules/base/appState.dart';
import 'state/modules/base/appViewModel.dart';

class AssistantSMS extends StatefulWidget {
  final EnvironmentSettings _env;
  const AssistantSMS(this._env, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  createState() => _AssistantSMSState(_env);
}

class _AssistantSMSState extends State<AssistantSMS> {
  final EnvironmentSettings _env;
  Store<AppState>? store;

  _AssistantSMSState(this._env) {
    initDependencyInjection(_env);
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

    return tempStore.state;
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
      store: store!,
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
