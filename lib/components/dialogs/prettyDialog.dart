import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

void prettyDialog(
  BuildContext dialogCtx,
  String appImage,
  String title,
  String description, {
  bool onlyCancelButton = false,
  String? okButtonText,
  Color? buttonOkColor,
  String? cancelButtonText,
  void Function(BuildContext)? onCancel,
  void Function(BuildContext)? onSuccess,
}) {
  String? localCancelButtonText = cancelButtonText;
  localCancelButtonText ??= onlyCancelButton
      ? getTranslations().fromKey(LocaleKey.noticeAccept)
      : getTranslations().fromKey(LocaleKey.close);

  List<Widget> buttons = List.empty(growable: true);
  if (onlyCancelButton == false) {
    buttons.add(
      PositiveButton(
        title: getTranslations().fromKey(LocaleKey.noticeAccept),
        onTap: () {
          if (onSuccess != null) onSuccess(dialogCtx);
          getNavigation().pop(dialogCtx);
        },
      ),
    );
  }

  buttons.add(
    PositiveButton(
      title: localCancelButtonText,
      onTap: onCancel == null ? null : () => onCancel(dialogCtx),
    ),
  );

  getDialog().showSimpleDialog(
    dialogCtx,
    '',
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LocalImage(imagePath: appImage),
        const EmptySpace1x(),
        GenericItemText(title),
        const EmptySpace1x(),
        GenericItemDescription(description),
      ],
    ),
    buttonBuilder: (BuildContext localCtx) => [
      getDialog().simpleDialogPositiveButton(
        localCtx,
        title: LocaleKey.ok,
        onTap: () {
          if (onSuccess != null) onSuccess(dialogCtx);
        },
      ),
      getDialog().simpleDialogCloseButton(
        localCtx,
        onTap: () {
          if (onCancel != null) onCancel(dialogCtx);
        },
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
