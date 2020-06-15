import 'package:redux/redux.dart';

import 'actions.dart';
import 'settingState.dart';

final settingReducer = combineReducers<SettingState>([
  TypedReducer<SettingState, ChangeLanguageAction>(_editLanguage),
]);

SettingState _editLanguage(SettingState state, ChangeLanguageAction action) {
  return state.copyWith(selectedLanguage: action.languageCode);
}
