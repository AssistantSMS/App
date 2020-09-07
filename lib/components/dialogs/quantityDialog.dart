import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../helpers/colourHelper.dart';
import '../../helpers/dialogHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

void showQuantityDialog(context, TextEditingController controller,
    {String title, Function(String) onSuccess}) {
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
  buttons.add(DialogButton(
    child: Text(
      Translations.get(context, LocaleKey.apply),
      style: TextStyle(
        color: getIsDark(context) ? Colors.black : Colors.white,
      ),
    ),
    onPressed: () {
      onSuccess(controller.text);
      Navigator.of(context).pop();
    },
  ));

  List<int> amounts = [1, 2, 3, 5, 10, 25];
  List<InputChip> inputs = List<InputChip>();
  for (var amount in amounts) {
    inputs.add(
      InputChip(
        label: Text(
          amount.toString(),
          style: TextStyle(
            color: getIsDark(context) ? Colors.black : Colors.white,
          ),
        ),
        backgroundColor: getSecondaryColour(context),
        onPressed: () => onControllerTextChange(
          controller,
          amount.toString(),
        ),
      ),
    );
  }

  showSimpleDialog(
    context,
    title ?? Translations.get(context, LocaleKey.quantity),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: controller,
          style: TextStyle(),
          autofocus: true,
          cursorColor: getSecondaryColour(context),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: inputs)
      ],
    ),
    buttons: buttons,
  );
}

void onControllerTextChange(
    TextEditingController textEditController, String content) {
  textEditController
    ..text = content
    ..selection = TextSelection.collapsed(offset: 0);
}
