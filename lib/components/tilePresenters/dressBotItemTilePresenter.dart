import 'package:assistantapps_flutter_common/components/tilePresenters/genericTilePresenter.dart';
import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/genericHelper.dart';
import '../../mapper/gameItemMapper.dart';

Widget dressBotItemTilePresenter(
        BuildContext context, GameItem gameItem, int index) =>
    genericListTile(
      context,
      leadingImage: gameItem.icon,
      name: gameItem.title,
      trailing: SizedBox(
        child: genericItemImage(
          context,
          getDressBotImage(gameItem.customisationSource),
          height: 50,
          disableZoom: true,
        ),
        height: 50,
        width: 50,
      ),
    );
