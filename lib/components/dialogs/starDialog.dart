import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helpers/dialogHelper.dart';
import '../starRating.dart';

void showStarDialog(context, String title,
    {int currentRating = 0, Function(int) onSuccess}) {
  List<DialogButton> buttons = List<DialogButton>();
  buttons.add(DialogButton(
    child: Text(
      getTranslations().fromKey(LocaleKey.close),
      style: TextStyle(
        color: getTheme().getIsDark(context) ? Colors.black : Colors.white,
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
