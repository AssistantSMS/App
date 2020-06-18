import 'package:flutter/material.dart';

import '../localization/localeKey.dart';
import '../localization/translations.dart';
import 'colourHelper.dart';

Widget getTextSpanFromTemplateAndArray(
    BuildContext context, LocaleKey templateLocaleKey, List<String> variables) {
  String template = Translations.get(context, templateLocaleKey);
  List<String> templateArray = template.split(new RegExp(r"\{.\}"));
  Color secondaryColour = getSecondaryColour(context);

  List<TextSpan> textSpans = List<TextSpan>();
  for (int templateVariableIndex = 0;
      templateVariableIndex < templateArray.length;
      templateVariableIndex++) {
    textSpans.add(TextSpan(text: templateArray[templateVariableIndex]));
    if (variables.length > templateVariableIndex) {
      textSpans.add(TextSpan(
        text: variables[templateVariableIndex],
        style: TextStyle(color: secondaryColour),
      ));
    }
  }

  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.subtitle1,
      children: textSpans,
    ),
    textAlign: TextAlign.center,
  );
}
