import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget adaptiveCheckbox(BuildContext context,
    {@required bool value,
    @required Color activeColor,
    @required void Function(bool newValue) onChanged}) {
  if (isiOS) return iosCheckbox(value, activeColor, onChanged);
  return androidCheckbox(value, activeColor, onChanged);
}
