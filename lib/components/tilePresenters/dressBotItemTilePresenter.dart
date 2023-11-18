import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../contracts/gameItem/gameItem.dart';
import '../../helpers/genericHelper.dart';
import '../../mapper/gameItemMapper.dart';

Widget dressBotItemTilePresenter(
    BuildContext context, GameItem gameItem, int index,
    {void Function()? onTap}) {
  String dressBotPckgImg = getDressBotImage(gameItem.customisationSource);
  return genericListTile(
    context,
    leadingImage: gameItem.icon,
    name: gameItem.title,
    trailing: (dressBotPckgImg.isNotEmpty)
        ? SizedBox(
            child: genericItemImage(
              context,
              dressBotPckgImg,
              height: 50,
              disableZoom: true,
            ),
            height: 50,
            width: 50,
          )
        : null,
    onTap: onTap,
  );
}
