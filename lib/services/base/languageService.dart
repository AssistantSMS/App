import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class LanguageService implements ILanguageService {
  @override
  LocalizationMap defaultLanguageMap() =>
      LocalizationMap(LocaleKey.english, 'en', 'gb');

  @override
  List<LocalizationMap> getLocalizationMaps() {
    List<LocalizationMap> supportedLanguageMaps = [
      defaultLanguageMap(),
      LocalizationMap(LocaleKey.brazilianPortuguese, 'pt-br', 'br'),
      LocalizationMap(LocaleKey.french, 'fr', 'fr'),
      LocalizationMap(LocaleKey.german, 'de', 'de'),
      LocalizationMap(LocaleKey.italian, 'it', 'it'),
      LocalizationMap(LocaleKey.russian, 'ru', 'ru'),
      LocalizationMap(LocaleKey.polish, 'pl', 'pl'),
      LocalizationMap(LocaleKey.spanish, 'es', 'es'),
    ];
    return supportedLanguageMaps;
  }

  @override
  List<Locale> supportedLocales() =>
      getLocalizationMaps().map((l) => Locale(l.code, "")).toList();

  @override
  List<LocaleKey> supportedLanguages() =>
      getLocalizationMaps().map((l) => l.name).toList();

  @override
  List<String> supportedLanguagesCodes() =>
      getLocalizationMaps().map((l) => l.code).toList();
}
