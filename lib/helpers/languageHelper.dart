import 'dart:async';

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/tilePresenters/languageTilePresenter.dart';
import '../contracts/search/dropdownOption.dart';
import '../pages/dialog/optionsListPageDialog.dart';

Future<String> langaugeSelectionPage(BuildContext context) async {
  var options = supportedLanguageMaps
      .map((l) => DropdownOption(
            getTranslations().fromKey(l.name),
            value: l.code,
          ))
      .toList();
  options.sort((a, b) => a.title.compareTo(b.title));
  return await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (context) => OptionsListPageDialog(
        getTranslations().fromKey(LocaleKey.language),
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
