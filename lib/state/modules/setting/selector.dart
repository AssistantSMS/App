import '../base/appState.dart';

String getSelectedLanguage(AppState state) {
  String langCode = state.settingState.selectedLanguage;
  if (langCode.isNotEmpty) return langCode;
  return 'en';
}

bool getIsPatron(AppState state) => state.settingState.isPatron;
