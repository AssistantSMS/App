import '../localization/localeKey.dart';
import '../localization/localizationMap.dart';

final List<LocalizationMap> supportedLanguageMaps = [
  LocalizationMap(LocaleKey.english, "en", "gb"),
  LocalizationMap(LocaleKey.german, "de", "de"),
  LocalizationMap(LocaleKey.spanish, "es", "es"),
  LocalizationMap(LocaleKey.french, "fr", "fr"),
  LocalizationMap(LocaleKey.italian, "it", "it"),
  LocalizationMap(LocaleKey.japanese, "ja", "jp"),
  LocalizationMap(LocaleKey.korean, "ko", "kr"),
  LocalizationMap(LocaleKey.polish, "po", "pl"),
  LocalizationMap(LocaleKey.brazilianPortuguese, "pt-br", "br"),
  LocalizationMap(LocaleKey.russian, "ru", "ru"),
  LocalizationMap(LocaleKey.chinese, "zh-hans", "cn"),
];

final List<LocaleKey> supportedLanguages =
    supportedLanguageMaps.map((l) => l.name).toList();
final List<String> supportedLanguagesCodes =
    supportedLanguageMaps.map((l) => l.code).toList();
