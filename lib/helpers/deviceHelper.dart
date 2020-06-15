import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import '../contracts/misc/actionItem.dart';
import 'colourHelper.dart';

bool isiOS = UniversalPlatform.isIOS;
bool isAndroid = UniversalPlatform.isAndroid;
bool isWeb = UniversalPlatform.isWeb;

List<Widget> actionItemToAndroidAction(List<ActionItem> actions) => actions
    .map((a) => IconButton(icon: Icon(a.icon), onPressed: a.onPressed))
    .toList();

List<Widget> actionItemToAppleAction(context, List<ActionItem> actions) =>
    actions
        .map((a) => GestureDetector(
              child: Icon(
                a.icon,
                color: getPrimaryColour(context),
              ),
              onTap: a.onPressed,
            ))
        .toList();
