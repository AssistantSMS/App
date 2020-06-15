import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrapmechanic_kurtlourens_com/helpers/deviceHelper.dart';

// Widget adaptiveCheckbox(BuildContext context,
//         {@required bool value,
//         @required Color activeColor,
//         @required void Function(bool newValue) onChanged}) =>
//     StoreConnector<AppState, SettingViewModel>(
//       converter: (store) => SettingViewModel.fromStore(store),
//       builder: (_, viewModel) =>
//           (isApple && viewModel.showMaterialTheme == false)
//               ? _iosCheckbox(context, value, activeColor, onChanged)
//               : _androidCheckbox(context, value, activeColor, onChanged),
//     );

Widget adaptiveCheckbox(BuildContext context,
    {@required bool value,
    @required Color activeColor,
    @required void Function(bool newValue) onChanged}) {
  if (isiOS) return _iosCheckbox(context, value, activeColor, onChanged);
  return _androidCheckbox(context, value, activeColor, onChanged);
}

Widget _androidCheckbox(BuildContext context, bool value, Color activeColor,
    Function(bool newVallue) onChanged) {
  return Switch(
    value: value,
    activeColor: activeColor,
    onChanged: onChanged,
  );
}

Widget _iosCheckbox(BuildContext context, bool value, Color activeColor,
    Function(bool newVallue) onChanged) {
  return CupertinoSwitch(
    value: value,
    activeColor: activeColor,
    onChanged: onChanged,
  );
}
