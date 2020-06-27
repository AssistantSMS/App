import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

import '../../helpers/colourHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../common/image.dart';

void prettyDialog(
    BuildContext context, String appImage, String title, String description,
    {Function() onCancel, Function() onSuccess}) {
  showDialog(
    context: context,
    builder: (_) => NetworkGiffyDialog(
      image: localImage(appImage),
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            )
          : null,
      description: Text(description, textAlign: TextAlign.center),
      entryAnimation: EntryAnimation.TOP,
      buttonOkText: Text(Translations.get(context, LocaleKey.ok)),
      buttonOkColor: getSecondaryColour(context),
      onOkButtonPressed: () {
        if (onSuccess != null) onSuccess();
        Navigator.pop(context);
      },
      buttonCancelText: Text(Translations.get(context, LocaleKey.cancel)),
      onCancelButtonPressed: onCancel,
    ),
  );
}
