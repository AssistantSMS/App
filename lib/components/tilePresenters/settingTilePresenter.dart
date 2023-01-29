import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget headingSettingTilePresenter(String name) {
  return ListTile(
    title: Text(
      name,
      maxLines: 1,
      style: const TextStyle(fontSize: 24),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget boolSettingTilePresenter(
  BuildContext context,
  String name,
  bool value, {
  void Function()? onChange,
}) {
  //
  void Function() tempOnChange;
  tempOnChange = () {
    if (onChange != null) onChange();
  };

  return FlatCard(
    child: genericListTile(context,
        leadingImage: null,
        name: name,
        trailing: AdaptiveCheckbox(
          value: value,
          activeColor: getTheme().getSecondaryColour(context),
          onChanged: (bool unused) => tempOnChange(),
        ),
        onTap: tempOnChange),
  );
}

Widget languageSettingTilePresenter(
  BuildContext context,
  String name,
  String value, {
  Function(Locale locale)? onChange,
}) {
  //
  tempOnChange() async {
    if (onChange == null) return;

    String? temp = await getNavigation().navigateAsync(
      context,
      navigateTo: (context) => const LanguageSelectionPageContent(),
    );
    if (temp != null) onChange(getTranslations().getLocaleFromKey(temp));
  }

  LocalizationMap currentLocal =
      getTranslations().getCurrentLocalizationMap(context, value);

  return FlatCard(
    child: languageTilePresenter(
      context,
      name,
      currentLocal.countryCode,
      trailingDisplay: currentLocal.name,
      onTap: tempOnChange,
    ),
  );
}
