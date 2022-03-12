import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../contracts/craftingIngredient/craftedUsing.dart';
import '../contracts/devDetail.dart';
import '../contracts/gameItem/gameItem.dart';
import '../contracts/gameItem/gameItemPageItem.dart';
import '../contracts/generated/LootChance.dart';
import '../contracts/packing/packedUsing.dart';
import '../contracts/recipe/recipe.dart';
import '../contracts/recipe/recipeBase.dart';
import '../contracts/recipe/recipePageItem.dart';
import '../contracts/recipeIngredient/recipeIngredient.dart';
import '../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../contracts/usedInRecipe/usedInRecipe.dart';
import '../integration/dependencyInjection.dart';
import '../services/json/interface/IGameItemJsonService.dart';
import '../services/json/interface/IRecipeJsonService.dart';
import '../services/json/lootItemJsonService.dart';
import 'itemsHelper.dart';
import 'repositoryHelper.dart';

Future<ResultWithValue<RecipePageItem>> recipePageItemFuture(
    context, String itemId) async {
  if (itemId == null) {
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'recipePageItemFuture - unknown type of item $itemId');
  }

  ResultWithValue<IRecipeJsonService> genRepo =
      getRecipeRepoFromId(context, itemId);
  if (genRepo.hasFailed) {
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'genericItemFuture - unknown type of item $itemId');
  }

  ResultWithValue<Recipe> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    ResultWithValue<List<RecipeIngredientDetails>> ingredientDetailsResult =
        await recipeIngredientDetailsFuture(context, itemResult.value.inputs);
    List<RecipeIngredientDetails> ingredientDetails =
        ingredientDetailsResult.isSuccess
            ? ingredientDetailsResult.value
            : List.empty(growable: true);
    return ResultWithValue<RecipePageItem>(
        true,
        RecipePageItem(
          recipe: itemResult.value,
          ingredientDetails: ingredientDetails,
        ),
        '');
  }
  return ResultWithValue<RecipePageItem>(
      false, RecipePageItem(), itemResult.errorMessage);
}

Future<ResultWithValue<List<Recipe>>> getAllRecipeFromLocaleKeys(
    dynamic context, List<LocaleKey> repoJsonStrings) async {
  List<Recipe> results = List.empty(growable: true);
  void Function(ResultWithValue<List<Recipe>> result) onFinishTask;
  onFinishTask = (ResultWithValue<List<Recipe>> result) {
    if (result.hasFailed) return;
    results.addAll(result.value);
  };
  List<Future<void>> tasks = List.empty(growable: true);
  for (LocaleKey repJson in repoJsonStrings) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    Future<void> getAllTask = repo.getAll(context).then(onFinishTask);
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  getLog().i('Number of Recipe items: ${results.length}');
  var sorted = results.sortedBy((recipe) => recipe.title).toList();

  return ResultWithValue(results.isNotEmpty, sorted, '');
}

Future<ResultWithValue<GameItemPageItem>> gameItemPageItemFuture(
    context, String itemId) async {
  if (itemId == null) {
    return ResultWithValue<GameItemPageItem>(false, GameItemPageItem(),
        'gameItemPageItemFuture - unknown type of item $itemId');
  }

  Future<ResultWithValue<List<CraftedUsing>>> craftingRecipesTask =
      craftingRecipesFuture(context, itemId);
  Future<ResultWithValue<List<UsedInRecipe>>> usedInRecipesTask =
      usedInRecipesFuture(context, itemId);
  Future<ResultWithValue<List<LootChance>>> lootChanceTask =
      getLootChanceFuture(context, itemId);
  Future<ResultWithValue<List<PackedUsing>>> packingInputTask =
      packingRecipesFuture(context, itemId);
  Future<ResultWithValue<List<PackedUsing>>> packingOutputTask =
      usedInPackingRecipesFuture(context, itemId);
  Future<ResultWithValue<List<DevDetail>>> devDetailsTask =
      getDevDetailsFuture(context, itemId);

  ResultWithValue<IGameItemJsonService> genRepo =
      getGameItemRepoFromId(context, itemId);
  if (genRepo.hasFailed) {
    return ResultWithValue<GameItemPageItem>(false, GameItemPageItem(),
        'gameItemPageItemFuture - unknown type of item $itemId');
  }

  ResultWithValue<GameItem> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    ResultWithValue<List<UsedInRecipe>> useInResult = await usedInRecipesTask;
    List<UsedInRecipe> usedInRecipes =
        useInResult.isSuccess ? useInResult.value : List.empty();
    ResultWithValue<List<CraftedUsing>> craftingRecipesResult =
        await craftingRecipesTask;
    List<CraftedUsing> craftingRecipes = craftingRecipesResult.isSuccess
        ? craftingRecipesResult.value
        : List.empty();
    ResultWithValue<List<LootChance>> lootChancesResult = await lootChanceTask;
    List<LootChance> lootChances =
        lootChancesResult.isSuccess ? lootChancesResult.value : List.empty();
    ResultWithValue<List<PackedUsing>> packingInputResult =
        await packingInputTask;
    List<PackedUsing> packingInputs =
        packingInputResult.isSuccess ? packingInputResult.value : List.empty();
    ResultWithValue<List<PackedUsing>> packingOutputResult =
        await packingOutputTask;
    List<PackedUsing> packingOutputs = packingOutputResult.isSuccess
        ? packingOutputResult.value
        : List.empty();
    ResultWithValue<List<DevDetail>> devDetailsResult = await devDetailsTask;
    List<DevDetail> devDetails = devDetailsResult.isSuccess //
        ? devDetailsResult.value
        : List.empty();

    return ResultWithValue<GameItemPageItem>(
        true,
        GameItemPageItem(
          gameItem: itemResult.value,
          usedInRecipes: usedInRecipes,
          craftingRecipes: craftingRecipes,
          lootChances: lootChances,
          packingInputs: packingInputs,
          packingOutputs: packingOutputs,
          devDetails: devDetails,
        ),
        '');
  }
  return ResultWithValue<GameItemPageItem>(
      false, GameItemPageItem(), itemResult.errorMessage);
}

Future<ResultWithValue<List<GameItem>>> getAllGameItemFromLocaleKeys(
    dynamic context, List<LocaleKey> repoJsonStrings) async {
  List<GameItem> results = List.empty(growable: true);
  void Function(ResultWithValue<List<GameItem>> result) onFinishTask;
  onFinishTask = (ResultWithValue<List<GameItem>> result) {
    if (result.hasFailed) return;
    results.addAll(result.value);
  };
  List<Future<void>> tasks = List.empty(growable: true);
  for (LocaleKey repJson in repoJsonStrings) {
    IGameItemJsonService repo = getGameItemRepo(repJson);
    if (repo == null) continue;
    Future<void> getAllTask = repo.getAll(context).then(onFinishTask);
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  getLog().i('Number of GameItem items: ${results.length}');
  var sorted = results.sortedBy((recipe) => recipe.title).toList();

  return ResultWithValue(results.isNotEmpty, sorted, '');
}

Future<ResultWithValue<RecipeIngredientDetails>>
    getRecipeIngredientDetailsFuture(
        BuildContext context, RecipeIngredient recipeIngredient) async {
  var itemId = recipeIngredient.id;
  ResultWithValue<IGameItemJsonService> genRepo =
      getGameItemRepoFromId(context, itemId);
  if (genRepo.hasFailed) {
    return ResultWithValue<RecipeIngredientDetails>(
      false,
      RecipeIngredientDetails(),
      'genericItemFuture - unknown type of item $itemId',
    );
  }

  ResultWithValue<GameItem> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    LocaleKey langFile = getLangJsonFromItemId(itemResult.value.id);
    return ResultWithValue<RecipeIngredientDetails>(
      true,
      RecipeIngredientDetails(
        id: itemResult.value.id,
        icon: itemResult.value.icon,
        title: itemResult.value.title,
        quantity: recipeIngredient.quantity,
        craftingStationName: getDisplayNameFromLangFileName(langFile),
      ),
      '',
    );
  }

  return ResultWithValue(false, null, itemResult.errorMessage);
}

Future<ResultWithValue<List<RecipeIngredientDetails>>>
    recipeIngredientDetailsFuture(
        context, List<RecipeIngredient> inputs) async {
  List<RecipeIngredientDetails> results = List.empty(growable: true);

  List<Future<void>> tasks = List.empty(growable: true);
  void Function(ResultWithValue<RecipeIngredientDetails> ingResult)
      onFinishTask;
  onFinishTask = (ResultWithValue<RecipeIngredientDetails> ingResult) {
    if (ingResult.hasFailed || ingResult.value == null) return;
    results.add(ingResult.value);
  };
  for (RecipeIngredient input in inputs) {
    if (input.id == null || input.id.isEmpty) continue;
    tasks.add(
      getRecipeIngredientDetailsFuture(context, input).then(onFinishTask),
    );
  }
  await Future.wait(tasks);

  // var sorted = results.sortedBy((recipe) => recipe.name).toList();

  return ResultWithValue(results.isNotEmpty, results, '');
}

Future<ResultWithValue<List<CraftedUsing>>> craftingRecipesFuture(
    context, String itemId) async {
  List<CraftedUsing> results = List.empty(growable: true);

  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    ResultWithValue<List<Recipe>> getOutput =
        await repo.getByOutputId(context, itemId);
    if (!getOutput.isSuccess) continue;
    for (Recipe recipe in getOutput.value) {
      List<Future<ResultWithValue<RecipeIngredientDetails>>> ingDetailsTask =
          List.empty(growable: true);
      for (RecipeIngredient recipeIng in recipe.inputs) {
        ingDetailsTask.add(
          getRecipeIngredientDetailsFuture(context, recipeIng),
        );
      }
      List<ResultWithValue<RecipeIngredientDetails>> ingDetailsResult =
          await Future.wait(ingDetailsTask);

      results.add(CraftedUsing(
        getDisplayNameFromLangFileName(repJson),
        ingDetailsResult
            .where((id) => id.isSuccess)
            .map((id) => id.value)
            .toList(),
      ));
    }
  }

  // results.sortedBy((recipe) => recipe.name);

  return ResultWithValue(results.isNotEmpty, results, '');
}

Future<ResultWithValue<List<UsedInRecipe>>> usedInRecipesFuture(
    context, String itemId) async {
  List<UsedInRecipe> results = List.empty(growable: true);
  void Function(LocaleKey langJsonPath, ResultWithValue<List<Recipe>> result)
      onFinishTask;
  onFinishTask =
      (LocaleKey langJsonPath, ResultWithValue<List<Recipe>> result) {
    if (result.hasFailed || result.value == null || result.value.isEmpty) {
      return;
    }
    results.add(
      UsedInRecipe(getDisplayNameFromLangFileName(langJsonPath), result.value),
    );
  };
  List<Future<void>> tasks = List.empty(growable: true);
  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    Future<void> getAllTask = repo.getByInputsId(context, itemId).then(
          (ResultWithValue<List<Recipe>> result) =>
              onFinishTask(repJson, result),
        );
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  // results.sortedBy((recipe) => recipe.name);

  return ResultWithValue(results.isNotEmpty, results, '');
}

Future<List<RecipeIngredientDetails>> getAllRequiredItemsForMultiple(
    context, List<RecipeIngredient> requiredItems) async {
  List<RecipeIngredient> allRequiredItems = List.empty(growable: true);
  for (RecipeIngredient requiredItem in requiredItems) {
    allRequiredItems.addAll(await getRequiredItems(context, requiredItem));
  }

  Map<String, RecipeIngredient> rawMaterialMap = <String, RecipeIngredient>{};
  for (RecipeIngredient reqItem in allRequiredItems) {
    if (rawMaterialMap.containsKey(reqItem.id)) {
      rawMaterialMap.update(
          reqItem.id,
          (orig) => RecipeIngredient(
                id: reqItem.id,
                quantity: orig.quantity + reqItem.quantity,
              ));
    } else {
      rawMaterialMap.putIfAbsent(reqItem.id, () => reqItem);
    }
  }

  List<RecipeIngredient> uniqueRequiredItems = rawMaterialMap.values.toList();
  ResultWithValue<List<RecipeIngredientDetails>> detailsResult =
      await recipeIngredientDetailsFuture(context, uniqueRequiredItems);
  if (!detailsResult.isSuccess) {
    return List.empty(growable: true);
  }

  return detailsResult.value.sortedBy((rd) => rd.quantity).toList();
}

Future<List<RecipeIngredient>> getRequiredItems(
    context, RecipeIngredient requiredItem) async {
  List<RecipeIngredient> tempRawMaterials = List.empty(growable: true);

  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    ResultWithValue<List<Recipe>> recipesToCreateXResult =
        await repo.getByOutputId(context, requiredItem.id);
    if (!recipesToCreateXResult.isSuccess ||
        recipesToCreateXResult.value.isEmpty) continue;

    for (RecipeIngredient recipe in recipesToCreateXResult.value[0].inputs) {
      RecipeIngredient out = recipesToCreateXResult.value[0].output;
      int multiplier = (requiredItem.quantity / out.quantity).ceil();
      if (multiplier < 1) {
        multiplier = 1;
      }
      tempRawMaterials.add(
        RecipeIngredient(id: recipe.id, quantity: recipe.quantity * multiplier),
      );
    }
  }

  List<RecipeIngredient> rawMaterialsResult = List.empty(growable: true);

  if (tempRawMaterials != null && tempRawMaterials.isEmpty) {
    rawMaterialsResult.add(requiredItem);
    return rawMaterialsResult;
  }

  for (int requiredIndex = 0;
      requiredIndex < tempRawMaterials.length;
      requiredIndex++) {
    RecipeIngredient rawMaterial = tempRawMaterials[requiredIndex];
    List<RecipeIngredient> requiredItems =
        await getRequiredItems(context, rawMaterial);
    rawMaterialsResult.addAll(requiredItems);
  }
  return rawMaterialsResult;
}

Future<List<RecipeIngredient>> getRequiredItemsSurfaceLevel(
    context, RecipeIngredient requiredItem) async {
  List<RecipeIngredient> tempRawMaterials = List.empty(growable: true);

  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    ResultWithValue<List<Recipe>> recipesToCreateXResult =
        await repo.getByOutputId(context, requiredItem.id);
    if (!recipesToCreateXResult.isSuccess ||
        recipesToCreateXResult.value.isEmpty) continue;

    for (RecipeIngredient recipe in recipesToCreateXResult.value[0].inputs) {
      RecipeIngredient out = recipesToCreateXResult.value[0].output;
      int multiplier = (requiredItem.quantity / out.quantity).ceil();
      if (multiplier < 1) {
        multiplier = 1;
      }
      tempRawMaterials.add(
        RecipeIngredient(id: recipe.id, quantity: recipe.quantity * multiplier),
      );
    }
  }
  return tempRawMaterials;
}

Future<ResultWithValue<List<LootChance>>> getLootChanceFuture(
    context, String itemId) async {
  LootItemJsonService service = LootItemJsonService();
  var appLootResult = await service.getById(context, itemId);
  if (!appLootResult.isSuccess) {
    return ResultWithValue(
        false, List.empty(growable: true), appLootResult.errorMessage);
  }
  var chances = appLootResult.value.chances;
  return ResultWithValue(chances.isNotEmpty, chances, '');
}

Future<ResultWithValue<List<PackedUsing>>> packingRecipesFuture(
    context, String itemId) async {
  //
  ResultWithValue<List<RecipeBase>> usedInPacking =
      await getPackingService().getByOutput(context, itemId);
  if (usedInPacking.hasFailed) {
    return ResultWithValue<List<PackedUsing>>(
        false, null, usedInPacking.errorMessage);
  }

  List<PackedUsing> results = List.empty(growable: true);

  for (RecipeBase usedInPack in usedInPacking.value) {
    ResultWithValue<RecipeIngredientDetails> outputDetail =
        await getRecipeIngredientDetailsFuture(
      context,
      RecipeIngredient(
        id: usedInPack.output.id,
        quantity: usedInPack.output.quantity,
      ),
    );
    if (outputDetail.hasFailed) continue;

    ResultWithValue<List<RecipeIngredientDetails>> inputsDetail =
        await recipeIngredientDetailsFuture(
      context,
      usedInPack.inputs
          .map((inp) => RecipeIngredient(id: inp.id, quantity: inp.quantity))
          .toList(),
    );
    if (inputsDetail.hasFailed) continue;

    results.add(PackedUsing(
      LocaleKey.craftedUsing,
      outputDetail.value,
      inputsDetail.value,
    ));
  }

  return ResultWithValue(results.isNotEmpty, results, '');
}

Future<ResultWithValue<List<PackedUsing>>> usedInPackingRecipesFuture(
    context, String itemId) async {
  //
  ResultWithValue<List<RecipeBase>> usedInPacking =
      await getPackingService().getByInput(context, itemId);
  if (usedInPacking.hasFailed) {
    return ResultWithValue<List<PackedUsing>>(
        false, null, usedInPacking.errorMessage);
  }

  List<PackedUsing> results = List.empty(growable: true);

  for (RecipeBase usedInPack in usedInPacking.value) {
    ResultWithValue<RecipeIngredientDetails> outputDetail =
        await getRecipeIngredientDetailsFuture(
      context,
      RecipeIngredient(
        id: usedInPack.output.id,
        quantity: usedInPack.output.quantity,
      ),
    );
    if (outputDetail.hasFailed) continue;

    List<RecipeIngredient> inputs = usedInPack.inputs
        .map((inp) => RecipeIngredient(id: inp.id, quantity: inp.quantity))
        .toList();
    ResultWithValue<List<RecipeIngredientDetails>> inputsDetail =
        await recipeIngredientDetailsFuture(context, inputs);
    if (inputsDetail.hasFailed) continue;

    results.add(PackedUsing(
      LocaleKey.craftedUsing,
      outputDetail.value,
      inputsDetail.value,
    ));
  }

  return ResultWithValue(results.isNotEmpty, results, '');
}

Future<ResultWithValue<List<DevDetail>>> getDevDetailsFuture(
    context, String itemId) async {
  //
  ResultWithValue<DevDetailFile> devDet =
      await getDevDetailService().getById(context, itemId);
  if (devDet.hasFailed) {
    return ResultWithValue<List<DevDetail>>(
        false, List.empty(), devDet.errorMessage);
  }

  return ResultWithValue(true, devDet.value.details, '');
}
