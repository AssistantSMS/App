import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helpers/colourHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';

// Widget searchBar(context, TextEditingController controller, String hintText,
//         void Function(String) onSearchTextChanged) =>
//     StoreConnector<AppState, SettingViewModel>(
//       converter: (store) => SettingViewModel.fromStore(store),
//       builder: (_, viewModel) => (isApple &&
//               viewModel.showMaterialTheme == false)
//           ? _appleSearchBar(context, controller, hintText, onSearchTextChanged)
//           : _androidSearchBar(
//               context, controller, hintText, onSearchTextChanged),
//     );

Widget searchBar(context, TextEditingController controller, String hintText,
        void Function(String) onSearchTextChanged) =>
    _androidSearchBar(context, controller, hintText, onSearchTextChanged);

Widget _androidSearchBar(context, TextEditingController controller,
    String hintText, void Function(String) onSearchTextChanged) {
  return Container(
    color: getPrimaryColour(context),
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextField(
            controller: controller,
            cursorColor: getSecondaryColour(context),
            decoration: InputDecoration(
                hintText: hintText == null
                    ? Translations.get(context, LocaleKey.searchItems)
                    : hintText,
                border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ),
        ),
      ),
    ),
  );
}

// Widget _appleSearchBar(context, TextEditingController controller,
//     String hintText, void Function(String) onSearchTextChanged) {
//   return Container(
//     color: getPrimaryColour(context),
//     child: Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Card(
//         child: CupertinoTextField(
//           style: TextStyle(
//             color: Colors.black,
//           ),
//           // toolbarOptions: ToolbarOptions(
//           //   selectAll: true,
//           //   paste: true,
//           //   copy: true,
//           // ),
//           controller: controller,
//           placeholder: hintText == null
//               ? Translations.get(context, LocaleKey.searchItems)
//               : hintText,
//           onChanged: onSearchTextChanged,
//           clearButtonMode: OverlayVisibilityMode.always,
//         ),
//       ),
//     ),
//   );
// }
