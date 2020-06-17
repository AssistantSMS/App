import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';
import 'genericTilePresenter.dart';

Widget gameItemTilePresenter(
    BuildContext context, GameItem gameItem, int index) {
  return genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: gameItem.title,
  );
}
