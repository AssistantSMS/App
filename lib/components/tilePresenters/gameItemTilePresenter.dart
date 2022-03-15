import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';

Widget gameItemTilePresenter(
    BuildContext context, GameItem gameItem, int index) {
  ListTile tile = genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: gameItem.title,
  );

  if (gameItem.isCreative) {
    return wrapInNewBanner(context, LocaleKey.craftable, tile);
  }

  return tile;
}
