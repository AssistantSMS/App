import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'selector.dart';

class SettingViewModel {
  final String selectedLanguage;

  SettingViewModel({
    this.selectedLanguage,
  });

  static SettingViewModel fromStore(Store<AppState> store) => SettingViewModel(
        selectedLanguage: getSelectedLanguage(store.state),
      );
}
