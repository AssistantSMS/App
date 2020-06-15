import 'package:flutter/material.dart';

import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

Widget wrapInNewBanner(
        BuildContext context, LocaleKey localeKey, Widget child) =>
    ClipRect(
      child: Banner(
        message: Translations.get(context, localeKey),
        location: BannerLocation.topEnd,
        child: child,
      ),
    );
