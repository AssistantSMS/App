import 'package:flutter/material.dart';

import '../../constants/AppPadding.dart';
import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/navigationHelper.dart';
import '../../pages/gameItem/gameItemDetailPage.dart';
import 'genericTilePresenter.dart';

Widget gameItemTilePresenter(
    BuildContext context, GameItem gameItem, int index) {
  var tile = genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: gameItem.title,
    onTap: () async => await navigateAwayFromHomeAsync(context,
        navigateTo: (context) => GameItemDetailPage(gameItem.id)),
  );

  if (index != 0) return tile;

  return Padding(
    padding: AppPadding.listTopPadding,
    child: tile,
  );
}
