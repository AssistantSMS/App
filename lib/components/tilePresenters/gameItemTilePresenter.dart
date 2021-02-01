import 'package:assistantapps_flutter_common/components/tilePresenters/genericTilePresenter.dart';
import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';

Widget gameItemTilePresenter(
        BuildContext context, GameItem gameItem, int index) =>
    genericListTile(
      context,
      leadingImage: gameItem.icon,
      name: gameItem.title,
    );
