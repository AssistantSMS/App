import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

void prettyDialog(
  BuildContext context,
  String appImage,
  String title,
  String description, {
  bool onlyCancelButton = false,
  Function() onCancel,
  Function() onSuccess,
}) {
  getDialog().showSimpleDialog(
    context,
    '',
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        localImage(appImage),
        if (title != null) ...[
          emptySpace1x(),
          genericItemText(title),
          emptySpace1x(),
        ],
        genericItemDescription(description),
      ],
    ),
    buttonBuilder: (BuildContext localCtx) => [
      getDialog().simpleDialogPositiveButton(
        localCtx,
        title: LocaleKey.ok,
        onTap: () {
          if (onSuccess != null) onSuccess();
        },
      ),
      getDialog().simpleDialogCloseButton(
        localCtx,
        onTap: onCancel,
      ),
    ],
  );
  // showDialog(
  //   context: context,
  //   builder: (_) => NetworkGiffyDialog(
  //     image: localImage(appImage),
  //     title: title != null
  //         ? Text(
  //             title,
  //             textAlign: TextAlign.center,
  //             style:
  //                 const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
  //           )
  //         : null,
  //     description: Text(description, textAlign: TextAlign.center),
  //     entryAnimation: EntryAnimation.TOP,
  //     buttonOkText: Text(getTranslations().fromKey(LocaleKey.ok)),
  //     buttonOkColor: getTheme().getSecondaryColour(context),
  //     onOkButtonPressed: () {
  //       if (onSuccess != null) onSuccess();
  //       Navigator.pop(context);
  //     },
  //     onlyCancelButton: onlyCancelButton,
  //     buttonCancelText: Text(onlyCancelButton
  //         ? getTranslations().fromKey(LocaleKey.ok)
  //         : getTranslations().fromKey(LocaleKey.cancel)),
  //     onCancelButtonPressed: onCancel,
  //   ),
  // );
}
