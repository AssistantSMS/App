import 'package:redux/redux.dart';

import '../setting/selector.dart';
import 'appState.dart';

class AppViewModel {
  final String selectedLanguage;

  AppViewModel({
    this.selectedLanguage,
  });

  static AppViewModel fromStore(Store<AppState> store) {
    return AppViewModel(
      selectedLanguage: getSelectedLanguage(store.state),
    );
  }
}
