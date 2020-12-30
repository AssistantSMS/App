import '../base/appState.dart';

String getSelectedLanguage(AppState state) =>
    state?.settingState?.selectedLanguage ?? 'en';
