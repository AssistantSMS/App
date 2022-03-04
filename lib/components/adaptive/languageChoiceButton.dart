import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget languageChoiceButton(context, bool showAppleTheme, onLocaleChange) =>
    isiOS
        ? _appleLanguageChoiceButton(context, showAppleTheme, onLocaleChange)
        : _androidLanguageChoiceButton(context, onLocaleChange);

Widget _androidLanguageChoiceButton(context, onLocaleChange) {
  return IconButton(
    icon: const Icon(Icons.language, color: Colors.white),
    onPressed: () async {
      var options = getLanguage()
          .getLocalizationMaps()
          .map((l) => DropdownOption(
                getTranslations().fromKey(l.name),
                value: l.code,
              ))
          .toList();
      var temp = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => OptionsListPageDialog(
            getTranslations().fromKey(LocaleKey.appLanguage),
            options,
            minListForSearch: 100,
          ),
        ),
      );
      if (temp != null) {
        onLocaleChange(getTranslations().getLocaleFromKey(temp));
      }
    },
  );
}

Widget _appleLanguageChoiceButton(
    context, bool showAppleTheme, onLocaleChange) {
  var color =
      showAppleTheme ? getTheme().getPrimaryColour(context) : Colors.white;
  return GestureDetector(
    child: const Icon(
      Icons.language,
      color: color,
    ),
    onTap: () {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(getTranslations().fromKey(LocaleKey.language)),
          actions: getLanguage()
              .getLocalizationMaps()
              .map(
                (choice) => CupertinoActionSheetAction(
                  child: Text(getTranslations().fromKey(choice.name)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onLocaleChange(
                      getTranslations().getLocaleFromLocalMap(choice),
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
