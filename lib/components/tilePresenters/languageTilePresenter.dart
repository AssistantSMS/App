import 'package:flutter/material.dart';

import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'genericTilePresenter.dart';

Widget languageTilePresenter(
    BuildContext context, String name, String countryCode,
    {LocaleKey trailingDisplay, Function() onTap}) {
  return genericListTileWithSubtitleAndImageCount(
    context,
    leadingImage: SizedBox(
      child: Image.asset('icons/flags/png/$countryCode.png',
          package: 'country_icons'),
      width: 50,
      height: 50,
    ),
    title: name,
    trailing: (trailingDisplay == null)
        ? null
        : Text(
            Translations.get(context, trailingDisplay ?? LocaleKey.unknown),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
    onTap: () {
      if (onTap != null) onTap();
    },
  );
}
