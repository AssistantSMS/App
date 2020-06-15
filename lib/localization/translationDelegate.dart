import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/SupportedLanguages.dart';
import '../integration/logging.dart';
import './translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  final Locale newLocale;

  const TranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) {
    logger.d('load: ' + locale.languageCode);
    return Translations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    return true;
  }
}
