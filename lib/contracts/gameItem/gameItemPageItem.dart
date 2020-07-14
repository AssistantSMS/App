import './gameItem.dart';
import '../craftingIngredient/craftedUsing.dart';
import '../generated/LootChance.dart';
import '../usedInRecipe/usedInRecipe.dart';

class GameItemPageItem {
  final GameItem gameItem;
  final List<UsedInRecipe> usedInRecipes;
  final List<CraftedUsing> craftingRecipes;
  final List<LootChance> lootChances;

  GameItemPageItem({
    this.gameItem,
    this.craftingRecipes,
    this.usedInRecipes,
    this.lootChances,
  });
}
