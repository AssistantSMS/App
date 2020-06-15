import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'localeKey.dart';

class Translations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  Translations(Locale locale) {
    this.locale = locale;
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static String get(BuildContext context, LocaleKey key) {
    return Localizations.of<Translations>(context, Translations).getLocale(key);
  }

  static Future<Translations> load(Locale locale) async {
    Translations appTranslations = Translations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/lang/language.${locale.languageCode}.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String getLocale(LocaleKey key) {
    String keyString = EnumToString.parse(key);
    return _localisedValues[keyString] ?? "$keyString not found";
  }
}
