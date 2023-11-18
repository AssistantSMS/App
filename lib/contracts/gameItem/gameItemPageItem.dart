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
    required this.gameItem,
    required this.craftingRecipes,
    required this.usedInRecipes,
    required this.lootChances,
    required this.packingInputs,
    required this.packingOutputs,
    required this.devDetails,
  });

  factory GameItemPageItem.initial() => GameItemPageItem(
        gameItem: GameItem.initial(),
        craftingRecipes: List.empty(),
        usedInRecipes: List.empty(),
        lootChances: List.empty(),
        packingInputs: List.empty(),
        packingOutputs: List.empty(),
        devDetails: List.empty(),
      );
}
