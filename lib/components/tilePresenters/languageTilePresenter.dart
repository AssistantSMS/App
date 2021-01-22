import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

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
            getTranslations().fromKey(trailingDisplay ?? LocaleKey.unknown),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
    onTap: () {
      if (onTap != null) onTap();
    },
  );
}
