import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helpers/colourHelper.dart';
import '../../helpers/dialogHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../starRating.dart';

void showStarDialog(context, String title,
    {int currentRating = 0, Function(int) onSuccess}) {
  List<DialogButton> buttons = List<DialogButton>();
  buttons.add(DialogButton(
    child: Text(
      Translations.get(context, LocaleKey.close),
      style: TextStyle(
        color: getIsDark(context) ? Colors.black : Colors.white,
      ),
    ),
    onPressed: () => Navigator.of(context).pop(),
  ));

  showSimpleDialog(
    context,
    title,
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        starRating(context, currentRating, size: 64, onTap: (int value) {
          onSuccess(value);
          Navigator.of(context).pop();
        })
      ],
    ),
    buttons: buttons,
  );
}
