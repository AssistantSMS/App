import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import 'genericTilePresenter.dart';

Widget headingSettingTilePresenter(String name) {
  return ListTile(
    title: Text(
      name,
      maxLines: 1,
      style: TextStyle(fontSize: 24),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget boolSettingTilePresenter(BuildContext context, String name, bool value,
    {Function() onChange}) {
  //
  void Function() tempOnChange = () {
    if (onChange != null) onChange();
  };

  return Card(
    child: genericListTile(context,
        leadingImage: null,
        name: name,
        trailing: adaptiveCheckbox(
          value: value,
          activeColor: getTheme().getSecondaryColour(context),
          onChanged: (bool unused) => tempOnChange(),
        ),
        onTap: tempOnChange),
    margin: const EdgeInsets.all(0.0),
  );
}

Widget languageSettingTilePresenter(
    BuildContext context, String name, String value,
    {Function(Locale locale) onChange}) {
  //
  void Function() tempOnChange = () async {
    if (onChange == null) return;

    var temp = await getNavigation().navigateAsync(
      context,
      navigateTo: (context) => LanguageSelectionPageContent(),
    );
    if (temp != null) onChange(getTranslations().getLocaleFromKey(temp));
  };
  LocalizationMap currentLocal = supportedLanguageMaps.firstWhere(
    (LocalizationMap localizationMap) => localizationMap.code == value,
    orElse: () => supportedLanguageMaps[0],
  );

  return Card(
    child: languageTilePresenter(
      context,
      name,
      currentLocal.countryCode,
      trailingDisplay: currentLocal.name,
      onTap: tempOnChange,
    ),
    margin: const EdgeInsets.all(0.0),
  );
}

Widget linkSettingTilePresenter(
  BuildContext context,
  String name, {
  IconData icon,
  Function() onTap,
}) {
  //
  void Function() tempOnTap = () {
    if (onTap != null) onTap();
  };

  return Card(
    child: genericListTileWithSubtitleAndImageCount(context,
        leadingImage:
            icon != null ? getCorrectlySizedImageFromIcon(context, icon) : null,
        title: name,
        onTap: tempOnTap),
    margin: const EdgeInsets.all(0.0),
  );
}
