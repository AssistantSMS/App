import 'package:flutter/material.dart';

import '../../helpers/analytics.dart';

Widget positiveButton({String title, String eventString, Function onPress}) =>
    RaisedButton(
      child: Text(title),
      onPressed: () {
        if (eventString != null) trackEvent(eventString);

        if (onPress != null) onPress();
      },
    );

Widget negativeButton({String title, String eventString, Function onPress}) =>
    MaterialButton(
      child: Text(title),
      color: Colors.red,
      onPressed: () {
        if (eventString != null) trackEvent(eventString);

        if (onPress != null) onPress();
      },
    );
