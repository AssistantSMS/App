import '../craftingIngredient/craftedUsing.dart';
import '../devDetail.dart';
import '../generated/LootChance.dart';
import '../packing/packedUsing.dart';
import '../usedInRecipe/usedInRecipe.dart';
import 'gameItem.dart';

class GameItemPageItem {
  final GameItem gameItem;
  final List<UsedInRecipe> usedInRecipes;
  final List<CraftedUsing> craftingRecipes;
  final List<LootChance> lootChances;
  final List<PackedUsing> packingOutputs;
  final List<PackedUsing> packingInputs;
  final List<DevDetail> devDetails;

  GameItemPageItem({
    this.gameItem,
    this.craftingRecipes,
    this.usedInRecipes,
    this.lootChances,
    this.packingInputs,
    this.packingOutputs,
    this.devDetails,
  });
}
