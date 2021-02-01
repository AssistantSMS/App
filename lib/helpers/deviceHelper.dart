import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

List<Widget> actionItemToAndroidAction(List<ActionItem> actions) => actions
    .map((a) => IconButton(icon: Icon(a.icon), onPressed: a.onPressed))
    .toList();

List<Widget> actionItemToAppleAction(context, List<ActionItem> actions) =>
    actions
        .map((a) => GestureDetector(
              child: Icon(
                a.icon,
                color: getTheme().getPrimaryColour(context),
              ),
              onTap: a.onPressed,
            ))
        .toList();

Widget customDivider() => isWeb ? Divider(thickness: .5) : Divider();
