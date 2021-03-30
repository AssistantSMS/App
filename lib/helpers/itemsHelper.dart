import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/gameItem/gameItem.dart';

import '../constants/IdPrefix.dart';
import '../contracts/recipeIngredient/recipeIngredient.dart';
import '../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../contracts/recipeIngredient/recipeIngredientTreeDetails.dart';
import '../integration/dependencyInjection.dart';
import '../services/json/interface/IGameItemJsonService.dart';
import '../services/json/interface/IRecipeJsonService.dart';
import 'futureHelper.dart';
import 'repositoryHelper.dart';

LocaleKey getLangJsonFromItemId(String itemId) {
  if (itemId.contains(IdPrefix.recipeCookBot))
    return LocaleKey.cookBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeCraftBot))
    return LocaleKey.craftBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeDispenser))
    return LocaleKey.dispenserRecipeJson;
  if (itemId.contains(IdPrefix.recipeDressBot))
    return LocaleKey.dressBotRecipeJson;
  if (itemId.contains(IdPrefix.recipeHideOut))
    return LocaleKey.hideOutRecipeJson;
  if (itemId.contains(IdPrefix.recipeRefinery))
    return LocaleKey.refineryRecipeJson;
  if (itemId.contains(IdPrefix.recipeWorkbench))
    return LocaleKey.workbenchRecipeJson;

  return LocaleKey.unknown;
}

ResultWithValue<IRecipeJsonService> getRecipeRepoFromId(context, String id) {
  LocaleKey key = getLangJsonFromItemId(id);

  if (key != LocaleKey.unknown) {
    return ResultWithValue<IRecipeJsonService>(true, getRecipeRepo(key), '');
  }

  getLog().e('getRecipeRepoFromId - unknown type of item: $id');
  return ResultWithValue<IRecipeJsonService>(
      false, null, 'getRecipeRepoFromId - unknown type of item: $id');
}

ResultWithValue<IGameItemJsonService> getGameItemRepoFromId(
    context, String id) {
  LocaleKey key = LocaleKey.title;

  if (id.contains(IdPrefix.ammo)) key = LocaleKey.ammoJson;
  if (id.contains(IdPrefix.blocks)) key = LocaleKey.blocksJson;
  if (id.contains(IdPrefix.buckets)) key = LocaleKey.bucketsJson;
  if (id.contains(IdPrefix.building)) key = LocaleKey.buildingJson;
  if (id.contains(IdPrefix.components)) key = LocaleKey.componentsJson;
  if (id.contains(IdPrefix.construction)) key = LocaleKey.constructionJson;
  if (id.contains(IdPrefix.consumable)) key = LocaleKey.consumableJson;
  if (id.contains(IdPrefix.consumableShared)) key = LocaleKey.consumSharedJson;
  if (id.contains(IdPrefix.containers)) key = LocaleKey.containersJson;
  if (id.contains(IdPrefix.craftbot)) key = LocaleKey.craftbotJson;
  if (id.contains(IdPrefix.customisation)) key = LocaleKey.customisationJson;
  if (id.contains(IdPrefix.decor)) key = LocaleKey.decorJson;
  if (id.contains(IdPrefix.fitting)) key = LocaleKey.fittingJson;
  if (id.contains(IdPrefix.fuel)) key = LocaleKey.fuelJson;
  if (id.contains(IdPrefix.harvest)) key = LocaleKey.harvestJson;
  if (id.contains(IdPrefix.industrial)) key = LocaleKey.industrialJson;
  if (id.contains(IdPrefix.interactive)) key = LocaleKey.interactiveJson;
  if (id.contains(IdPrefix.interactiveShared))
    key = LocaleKey.interactiveSharedJson;
  if (id.contains(IdPrefix.interactiveUpgradable))
    key = LocaleKey.interactiveUpgradableJson;
  if (id.contains(IdPrefix.interactiveContainer))
    key = LocaleKey.interactiveContainerJson;
  if (id.contains(IdPrefix.light)) key = LocaleKey.lightJson;
  if (id.contains(IdPrefix.manMade)) key = LocaleKey.manMadeJson;
  if (id.contains(IdPrefix.other)) key = LocaleKey.otherJson;
  if (id.contains(IdPrefix.outfit)) key = LocaleKey.outfitJson;
  if (id.contains(IdPrefix.packingCrate)) key = LocaleKey.packingCrateJson;
  if (id.contains(IdPrefix.plant)) key = LocaleKey.plantJson;
  if (id.contains(IdPrefix.power)) key = LocaleKey.powerJson;
  if (id.contains(IdPrefix.resources)) key = LocaleKey.resourcesJson;
  if (id.contains(IdPrefix.robot)) key = LocaleKey.robotJson;
  if (id.contains(IdPrefix.scrap)) key = LocaleKey.scrapJson;
  if (id.contains(IdPrefix.spaceship)) key = LocaleKey.spaceshipJson;
  if (id.contains(IdPrefix.survival)) key = LocaleKey.survivalJson;
  if (id.contains(IdPrefix.tool)) key = LocaleKey.toolJson;
  if (id.contains(IdPrefix.vehicle)) key = LocaleKey.vehicleJson;
  if (id.contains(IdPrefix.warehouse)) key = LocaleKey.warehouseJson;

  if (key != LocaleKey.title) {
    return ResultWithValue<IGameItemJsonService>(
        true, getGameItemRepo(key), '');
  }

  getLog().e('getGameItemRepoFromId - unknown type of item: $id');
  return ResultWithValue<IGameItemJsonService>(
      false, null, 'getGameItemRepoFromId - unknown type of item: $id');
}

Future<ResultWithValue<RecipeIngredientDetails>> recipeIngredientDetails(
    context, RecipeIngredient recipeIngredient) async {
  //
  ResultWithValue<RecipeIngredientDetails> genericResult =
      await getRecipeIngredientDetailsFuture(context, recipeIngredient);
  if (genericResult.isSuccess) {
    return ResultWithValue<RecipeIngredientDetails>(
        true, genericResult.value, '');
  }

  return ResultWithValue<RecipeIngredientDetails>(
      false,
      RecipeIngredientDetails(),
      'recipeIngredientDetails - unknown type of item: ${recipeIngredient.id}');
}

Future<List<RecipeIngredientDetails>> getRequiredItemDetailsSurfaceLevel(
    context, RecipeIngredient recipeIngredient) async {
  List<RecipeIngredientDetails> tempRequiredItems = List.empty(growable: true);

  List<RecipeIngredient> ingredients = await getRequiredItemsSurfaceLevel(
    context,
    RecipeIngredient(
      id: recipeIngredient.id,
      quantity: recipeIngredient.quantity,
    ),
  );

  for (RecipeIngredient requiredItem in ingredients) {
    ResultWithValue<IGameItemJsonService> genRepo =
        getGameItemRepoFromId(context, requiredItem.id);
    if (genRepo.hasFailed) continue;
    ResultWithValue<GameItem> reqResult =
        await genRepo.value.getById(context, requiredItem.id);
    if (reqResult.hasFailed) continue;
    LocaleKey langFile = getLangJsonFromItemId(requiredItem.id);
    tempRequiredItems.add(
      RecipeIngredientDetails(
        id: reqResult.value.id,
        icon: reqResult.value.icon,
        title: reqResult.value.title,
        quantity: requiredItem.quantity,
        craftingStationName: getDisplayNameFromLangFileName(langFile),
      ),
    );
  }

  return tempRequiredItems;
}

Future<List<RecipeIngredientTreeDetails>> getAllRecipeIngredientDetailsForTree(
    context, RecipeIngredient ingredient) async {
  List<RecipeIngredientTreeDetails> rawMaterials = List.empty(growable: true);

  List<RecipeIngredientDetails> requiredItemDetails =
      await getRequiredItemDetailsSurfaceLevel(context, ingredient);

  for (RecipeIngredientDetails requiredItemDetail in requiredItemDetails) {
    rawMaterials.addAll(await getAllRequiredItemsForTree(
      context,
      [
        RecipeIngredient(
          id: requiredItemDetail.id,
          quantity: requiredItemDetail.quantity,
        )
      ],
    ));
  }
  return rawMaterials;
}

Future<List<RecipeIngredientTreeDetails>> getAllRequiredItemsForTree(
    context, List<RecipeIngredient> requiredItems) async {
  List<RecipeIngredientTreeDetails> rawMaterials = List.empty(growable: true);
  for (RecipeIngredient reqItem in requiredItems) {
    ResultWithValue<RecipeIngredientDetails> itemDetail =
        await getRecipeIngredientDetailsFuture(context, reqItem);
    if (itemDetail.hasFailed) continue;

    RecipeIngredientTreeDetails itemTreeDetails =
        RecipeIngredientTreeDetails.fromRequiredItemDetails(
            itemDetail.value, 1);

    itemTreeDetails.children = await getAllRecipeIngredientDetailsForTree(
      context,
      reqItem,
    );
    rawMaterials.add(itemTreeDetails);
  }
  return rawMaterials;
}
