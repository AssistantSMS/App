import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget getTextSpanFromTemplateAndArray(
    BuildContext context, LocaleKey templateLocaleKey, List<String> variables) {
  String template = getTranslations().fromKey(templateLocaleKey);
  List<String> templateArray = template.split(RegExp(r"\{.\}"));
  Color secondaryColour = getTheme().getSecondaryColour(context);

  List<TextSpan> textSpans = List.empty(growable: true);
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
