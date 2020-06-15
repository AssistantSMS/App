import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/components/tilePresenters/languageTilePresenter.dart';
import 'package:scrapmechanic_kurtlourens_com/localization/localizationMap.dart';

import '../constants/SupportedLanguages.dart';
import '../contracts/search/dropdownOption.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';
import '../pages/dialog/optionsListPageDialog.dart';

Future<String> langaugeSelectionPage(BuildContext context) async {
  var options = supportedLanguageMaps
      .map((l) => DropdownOption(
            Translations.get(context, l.name),
            value: l.code,
          ))
      .toList();
  options.sort((a, b) => a.title.compareTo(b.title));
  return await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (context) => OptionsListPageDialog(
        Translations.get(context, LocaleKey.language),
        options,
        minListForSearch: 100,
        customPresenter: (BuildContext innerC, DropdownOption opt, int) {
          LocalizationMap supportedLang =
              supportedLanguageMaps.firstWhere((sl) => sl.code == opt.value);
          return languageTilePresenter(
            innerC,
            opt.title,
            supportedLang.countryCode,
            onTap: () => Navigator.of(context).pop(opt.value),
          );
        },
      ),
    ),
  );
}
