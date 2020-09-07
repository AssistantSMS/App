import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'actions.dart';
import 'selector.dart';

class SettingViewModel {
  final String selectedLanguage;
  final Function(Locale) changeLanguage;

  SettingViewModel({
    this.selectedLanguage,
    this.changeLanguage,
  });

  static SettingViewModel fromStore(Store<AppState> store) => SettingViewModel(
        selectedLanguage: getSelectedLanguage(store.state),
        changeLanguage: (Locale locale) => store.dispatch(
          ChangeLanguageAction(locale.languageCode),
        ),
      );
}
