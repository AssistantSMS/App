import 'package:redux/redux.dart';

import 'actions.dart';
import 'settingState.dart';

final settingReducer = combineReducers<SettingState>([
  TypedReducer<SettingState, ChangeLanguageAction>(_editLanguage),
  TypedReducer<SettingState, SetIsPatron>(_setIsPatron),
]);

SettingState _editLanguage(SettingState state, ChangeLanguageAction action) {
  return state.copyWith(selectedLanguage: action.languageCode);
}

SettingState _setIsPatron(SettingState state, SetIsPatron action) =>
    state.copyWith(isPatron: action.newIsPatron);
