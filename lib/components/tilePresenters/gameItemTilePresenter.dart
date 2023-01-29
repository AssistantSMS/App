import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';

Widget gameItemTilePresenter(
  BuildContext context,
  GameItem gameItem,
  int index, {
  void Function()? onTap,
}) {
  String title = gameItem.title;
  if (gameItem.title.isEmpty) {
    title = getTranslations().fromKey(LocaleKey.unknown);
  }

  Widget? trailing;
  TextStyle trailingTextStyle = TextStyle(color: Colors.grey[500]);
  if (gameItem.isChallenge) {
    trailing = Text('Challenge', style: trailingTextStyle); // TODO translate
  }
  if (gameItem.isCreative) {
    trailing = Text(
      getTranslations().fromKey(LocaleKey.creative),
      style: trailingTextStyle,
    );
  }

  return genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: title,
    trailing: trailing,
  );
}
