import 'package:flutter/material.dart';

import '../integration/flash.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

void initSnackbar(context) => FlashHelper.init(context);

void showSnackbar(context, LocaleKey lang,
    {Duration duration, Function onTap}) {
  FlashHelper.actionBar(
    context,
    message: Translations.get(context, lang),
    duration: duration,
    primaryAction: (context, controller, setState) {
      return FlatButton(
        child: Text(
          Translations.get(context, LocaleKey.view),
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          controller.dismiss();
          onTap();
        },
      );
    },
  );
}

// void showSnackbar(context, LocaleKey lang,
//     {Duration duration, LocaleKey actionLang, Function onTap}) {
//   showFlash(
//     context: context,
//     duration: duration,
//     builder: (_, controller) {
//       Widget actionButton;
//       if (actionLang != null) {
//         actionButton = FlatButton(
//           onPressed: () => controller.dismiss(true),
//           child: Text(
//             Translations.get(context, LocaleKey.view),
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       }
//       return Flash(
//         controller: controller,
//         backgroundColor: getSecondaryColour(context),
//         onTap: () => controller.dismiss(),
//         child: FlashBar(
//           message: Text(Translations.get(context, lang)),
//           primaryAction: actionButton,
//         ),
//       );
//     },
//   ).then((result) {
//     if (result != null && result == true && onTap != null) {
//       onTap();
//     }
//   }).catchError((error) {
//     logger.e(error);
//   });
// }
