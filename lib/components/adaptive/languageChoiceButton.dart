import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/SupportedLanguages.dart';
import '../../contracts/search/dropdownOption.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/deviceHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/localization.dart';
import '../../localization/translations.dart';
import '../../pages/dialog/optionsListPageDialog.dart';

Widget languageChoiceButton(context, bool showAppleTheme, onLocaleChange) =>
    isiOS
        ? _appleLanguageChoiceButton(context, showAppleTheme, onLocaleChange)
        : _androidLanguageChoiceButton(context, onLocaleChange);

Widget _androidLanguageChoiceButton(context, onLocaleChange) {
  return IconButton(
    icon: Icon(Icons.language, color: Colors.white),
    onPressed: () async {
      var options = supportedLanguageMaps
          .map((l) => DropdownOption(
                Translations.get(context, l.name),
                value: l.code,
              ))
          .toList();
      var temp = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => OptionsListPageDialog(
            Translations.get(context, LocaleKey.appLanguage),
            options,
            minListForSearch: 100,
          ),
        ),
      );
      if (temp != null) onLocaleChange(localization.getLocaleFromKey(temp));
    },
  );
}

Widget _appleLanguageChoiceButton(
    context, bool showAppleTheme, onLocaleChange) {
  var color = showAppleTheme ? getPrimaryColour(context) : Colors.white;
  return GestureDetector(
    child: Icon(
      Icons.language,
      color: color,
    ),
    onTap: () {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(Translations.get(context, LocaleKey.language)),
          actions: supportedLanguageMaps
              .map(
                (choice) => CupertinoActionSheetAction(
                  child: Text(Translations.get(context, choice.name)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    return onLocaleChange(
                      localization.getLocaleFromLocalMap(choice),
                    );
                  },
                ),
              )
              .toList(),
        ),
      );
    },
  );
}
