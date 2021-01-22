import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../integration/flash.dart';

void initSnackbar(context) => FlashHelper.init(context);

void showSnackbar(context, LocaleKey lang,
    {Duration duration, Function onTap}) {
  FlashHelper.actionBar(
    context,
    message: getTranslations().fromKey(lang),
    duration: duration,
    primaryAction: (context, controller, setState) {
      return FlatButton(
        child: Text(
          getTranslations().fromKey(LocaleKey.view),
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
//             getTranslations().fromKey(LocaleKey.view),
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       }
//       return Flash(
//         controller: controller,
//         backgroundColor: getSecondaryColour(context),
//         onTap: () => controller.dismiss(),
//         child: FlashBar(
//           message: Text(getTranslations().fromKey(lang)),
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
