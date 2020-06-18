import './gameItem.dart';
import '../craftingIngredient/craftedUsing.dart';
import '../usedInRecipe/usedInRecipe.dart';

class GameItemPageItem {
  final GameItem gameItem;
  final List<UsedInRecipe> usedInRecipes;
  final List<CraftedUsing> craftingRecipes;

  GameItemPageItem({
    this.gameItem,
    this.craftingRecipes,
    this.usedInRecipes,
  });
}
