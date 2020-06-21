import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/Routes.dart';
import 'package:scrapmechanic_kurtlourens_com/integration/logging.dart';

import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';
import 'navigationHelper.dart';

void showSnackbar(context, LocaleKey lang,
    {Duration duration, LocaleKey actionLang, Function onTap}) {
  showFlash(
    context: context,
    duration: duration,
    builder: (_, controller) {
      Widget actionButton;
      if (actionLang != null) {
        actionButton = FlatButton(
          onPressed: () => controller.dismiss(true),
          child: Text(
            Translations.get(context, LocaleKey.view),
            style: TextStyle(color: Colors.white),
          ),
        );
      }
      return Flash(
        controller: controller,
        backgroundColor: getSecondaryColour(context),
        onTap: () => controller.dismiss(),
        child: FlashBar(
          message: Text(Translations.get(context, lang)),
          primaryAction: actionButton,
        ),
      );
    },
  ).then((result) {
    if (result != null && result == true && onTap != null) {
      onTap();
    }
  }).catchError((error) {
    logger.e(error);
  });
}
