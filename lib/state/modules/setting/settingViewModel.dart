import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'actions.dart';
import 'selector.dart';

class SettingViewModel {
  final String selectedLanguage;
  final bool isPatron;
  final Function(Locale) changeLanguage;
  final Function(bool) setIsPatron;

  SettingViewModel({
    required this.selectedLanguage,
    required this.isPatron,
    required this.changeLanguage,
    required this.setIsPatron,
  });

  static SettingViewModel fromStore(Store<AppState> store) => SettingViewModel(
        selectedLanguage: getSelectedLanguage(store.state),
        isPatron: getIsPatron(store.state),
        changeLanguage: (Locale locale) => store.dispatch(
          ChangeLanguageAction(locale.languageCode),
        ),
        setIsPatron: (bool isPatron) => store.dispatch(SetIsPatron(isPatron)),
      );
}
