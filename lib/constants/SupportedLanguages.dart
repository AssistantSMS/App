import '../localization/localeKey.dart';
import '../localization/localizationMap.dart';

final List<LocalizationMap> supportedLanguageMaps = [
  LocalizationMap(LocaleKey.english, "en", "gb"),
  LocalizationMap(LocaleKey.german, "de", "de"),
];

final List<LocaleKey> supportedLanguages =
    supportedLanguageMaps.map((l) => l.name).toList();
final List<String> supportedLanguagesCodes =
    supportedLanguageMaps.map((l) => l.code).toList();
