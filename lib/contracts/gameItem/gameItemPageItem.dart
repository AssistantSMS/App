import './gameItem.dart';
import '../usedInRecipe/usedInRecipe.dart';

class GameItemPageItem {
  final GameItem gameItem;
  final List<UsedInRecipe> usedInRecipes;

  GameItemPageItem({
    this.gameItem,
    this.usedInRecipes,
  });
}
