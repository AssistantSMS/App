import '../contracts/gameItem/gameItem.dart';
import '../contracts/gameItem/gameItemBase.dart';
import '../contracts/gameItem/gameItemLang.dart';

List<GameItem> mapGameItemItems(
    context, List<GameItemBase> baseItems, List<GameItemLang> details) {
  List<GameItem> result = List.empty(growable: true);

  for (var baseIndex = 0; baseIndex < baseItems.length; baseIndex++) {
    var base = baseItems[baseIndex];
    var detail = details[baseIndex];
    if (base.id == null) continue;
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
