import 'package:flutter/material.dart';

import '../constants/AppImage.dart';
import '../contracts/enum/customisationSourceType.dart';
import '../contracts/gameItem/gameItem.dart';
import '../contracts/gameItem/gameItemBase.dart';
import '../contracts/gameItem/gameItemLang.dart';

List<GameItem> mapGameItemItems(
  BuildContext context,
  List<GameItemBase> baseItems,
  List<GameItemLang> details,
) {
  List<GameItem> result = List.empty(growable: true);

  for (var baseIndex = 0; baseIndex < baseItems.length; baseIndex++) {
    GameItemBase base = baseItems[baseIndex];
    GameItemLang detail = details[baseIndex];

    if (base.id == detail.id) {
      result.add(GameItem.fromBaseAndLang(base, detail));
      continue;
    } else {
      for (var detail in details) {
        if (base.id == detail.id) {
          result.add(GameItem.fromBaseAndLang(base, detail));
          break;
        }
      }
    }
  }

  return result;
}

String getDressBotImage(CustomisationSourceType customisationSource) {
  switch (customisationSource) {
    case CustomisationSourceType.common:
      return AppImage.outfitCommon;
    case CustomisationSourceType.rare:
      return AppImage.outfitRare;
    case CustomisationSourceType.epic:
      return AppImage.outfitEpic;
    default:
      return '';
  }
}
