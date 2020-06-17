import 'package:flutter/material.dart';

import '../../constants/AppPadding.dart';
import '../../contracts/gameItem/gameItem.dart';
import 'genericTilePresenter.dart';

Widget gameItemTilePresenter(
    BuildContext context, GameItem gameItem, int index) {
  var tile = genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: gameItem.title,
  );

  if (index != 0) return tile;

  return Padding(
    padding: AppPadding.listTopPadding,
    child: tile,
  );
}
