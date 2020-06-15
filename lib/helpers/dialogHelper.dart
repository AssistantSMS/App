import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';

void showSimpleDialog(context, String title, Widget content,
    {List<DialogButton> buttons}) {
  Alert(
    context: context,
    title: title,
    closeFunction: () {},
    style: AlertStyle(
      titleStyle: TextStyle(
        color: getIsDark(context) ? Colors.white : Colors.black,
      ),
    ),
    content: content,
    buttons: buttons,
  ).show();
}

void showSimpleHelpDialog(context, String title, String helpContent,
    {List<DialogButton> buttons}) {
  showSimpleDialog(
    context,
    title,
    Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[Text(helpContent)]),
    buttons: [simpleDialogCloseButton(context)],
  );
}

Widget simpleDialogCloseButton(context, {Function onTap}) => DialogButton(
      child: Text(
        Translations.get(context, LocaleKey.close),
        style: TextStyle(
          color: getIsDark(context) ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onTap != null) onTap();
      },
    );

Widget simpleDialogPositiveButton(context, {LocaleKey title, Function onTap}) =>
    DialogButton(
      child: Text(
        Translations.get(context, title ?? LocaleKey.apply),
        style: TextStyle(
          color: getIsDark(context) ? Colors.black : Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        if (onTap != null) onTap();
      },
    );
