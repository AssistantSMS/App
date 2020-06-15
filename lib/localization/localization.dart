import 'dart:ui';

import '../constants/SupportedLanguages.dart';
import '../integration/logging.dart';
import 'localizationMap.dart';

class Localization {
  static final Localization _localization = Localization._internal();

  factory Localization() {
    return _localization;
  }

  Localization._internal();

  Locale getLocaleFromKey(String supportedLanguageKey) {
    int langIndex = supportedLanguagesCodes.indexOf(supportedLanguageKey);
    if (langIndex < 0) {
      logger.e('language not found ($supportedLanguageKey), revert to english');
      return Locale('en');
    }
    return Locale(supportedLanguageKey);
  }

  Locale getLocaleFromLocalMap(LocalizationMap localeMap) =>
      Locale(localeMap.code);

  //returns the list of supported Locales
  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language, ""));
  //function to be invoked when changing the language
  LocaleChangeCallback onLocaleChanged;
}

Localization localization = Localization();
typedef void LocaleChangeCallback(Locale locale);
