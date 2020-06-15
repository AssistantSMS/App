import 'package:scrapmechanic_kurtlourens_com/state/modules/base/appState.dart';
import 'package:redux/redux.dart';

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
