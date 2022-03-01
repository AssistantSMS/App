import '../base/appState.dart';

String getSelectedLanguage(AppState state) {
  String langCode = state?.settingState?.selectedLanguage ?? 'en';
  if (langCode.isNotEmpty) return langCode;
  return 'en';
}
