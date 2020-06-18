import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:scrapmechanic_kurtlourens_com/contracts/craftingIngredient/craftedUsing.dart';

import '../contracts/gameItem/gameItem.dart';
import '../contracts/gameItem/gameItemPageItem.dart';
import '../contracts/recipe/recipe.dart';
import '../contracts/recipe/recipePageItem.dart';
import '../contracts/recipeIngredient/recipeIngredient.dart';
import '../contracts/recipeIngredient/recipeIngredientDetail.dart';
import '../contracts/results/resultWithValue.dart';
import '../contracts/usedInRecipe/usedInRecipe.dart';
import '../integration/dependencyInjection.dart';
import '../integration/logging.dart';
import '../localization/localeKey.dart';
import '../services/interface/IGameItemJsonService.dart';
import '../services/interface/IRecipeJsonService.dart';
import 'deviceHelper.dart';
import 'itemsHelper.dart';
import 'repositoryHelper.dart';

Future<ResultWithValue<PackageInfo>> currentAppVersion() async {
  bool hasPackageInfo = isAndroid || isiOS;
  if (!hasPackageInfo) {
    return ResultWithValue<PackageInfo>(
        false, PackageInfo(), 'platform not supported');
  }
  try {
    var packInfo = await PackageInfo.fromPlatform();
    return ResultWithValue<PackageInfo>(true, packInfo, '');
  } catch (exception) {
    return ResultWithValue<PackageInfo>(
        false, PackageInfo(), exception.toString());
  }
}

Future<ResultWithValue<RecipePageItem>> recipePageItemFuture(
    context, String itemId) async {
  if (itemId == null)
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'recipePageItemFuture - unknown type of item $itemId');

  ResultWithValue<IRecipeJsonService> genRepo =
      getRecipeRepoFromId(context, itemId);
  if (genRepo.hasFailed)
    return ResultWithValue<RecipePageItem>(false, RecipePageItem(),
        'genericItemFuture - unknown type of item $itemId');

  ResultWithValue<Recipe> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    ResultWithValue<List<RecipeIngredientDetails>> ingredientDetailsResult =
        await recipeIngredientDetailsFuture(context, itemResult.value.inputs);
    List<RecipeIngredientDetails> ingredientDetails =
        ingredientDetailsResult.isSuccess
            ? ingredientDetailsResult.value
            : List<RecipeIngredientDetails>();
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
  List<Recipe> results = List<Recipe>();
  var onFinishTask = (ResultWithValue<List<Recipe>> result) {
    if (result.hasFailed) return;
    results.addAll(result.value);
  };
  List<Future<ResultWithValue<List<Recipe>>>> tasks =
      List<Future<ResultWithValue<List<Recipe>>>>();
  for (var repJson in repoJsonStrings) {
    var repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    var getAllTask = repo.getAll(context).then(onFinishTask);
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  logger.i('Number of Recipe items: ${results.length}');
  var sorted = results.sortedBy((recipe) => recipe.title).toList();

  return ResultWithValue(results.length > 0, sorted, '');
}

Future<ResultWithValue<GameItemPageItem>> gameItemPageItemFuture(
    context, String itemId) async {
  if (itemId == null) {
    return ResultWithValue<GameItemPageItem>(false, GameItemPageItem(),
        'gameItemPageItemFuture - unknown type of item $itemId');
  }

  var craftingRecipesTask = craftingRecipesFuture(context, itemId);
  var usedInRecipesTask = usedInRecipesFuture(context, itemId);

  ResultWithValue<IGameItemJsonService> genRepo =
      getGameItemRepoFromId(context, itemId);
  if (genRepo.hasFailed)
    return ResultWithValue<GameItemPageItem>(false, GameItemPageItem(),
        'gameItemPageItemFuture - unknown type of item $itemId');

  ResultWithValue<GameItem> itemResult =
      await genRepo.value.getById(context, itemId);
  if (itemResult.isSuccess) {
    ResultWithValue<List<UsedInRecipe>> useInResult = await usedInRecipesTask;
    List<UsedInRecipe> usedInRecipes =
        useInResult.isSuccess ? useInResult.value : List<UsedInRecipe>();
    ResultWithValue<List<CraftedUsing>> craftingRecipesResult =
        await craftingRecipesTask;
    List<CraftedUsing> craftingRecipes = craftingRecipesResult.isSuccess
        ? craftingRecipesResult.value
        : List<CraftedUsing>();
    return ResultWithValue<GameItemPageItem>(
        true,
        GameItemPageItem(
          gameItem: itemResult.value,
          usedInRecipes: usedInRecipes,
          craftingRecipes: craftingRecipes,
        ),
        '');
  }
  return ResultWithValue<GameItemPageItem>(
      false, GameItemPageItem(), itemResult.errorMessage);
}

Future<ResultWithValue<List<GameItem>>> getAllGameItemFromLocaleKeys(
    dynamic context, List<LocaleKey> repoJsonStrings) async {
  List<GameItem> results = List<GameItem>();
  var onFinishTask = (ResultWithValue<List<GameItem>> result) {
    if (result.hasFailed) return;
    results.addAll(result.value);
  };
  List<Future<ResultWithValue<List<GameItem>>>> tasks =
      List<Future<ResultWithValue<List<GameItem>>>>();
  for (var repJson in repoJsonStrings) {
    var repo = getGameItemRepo(repJson);
    if (repo == null) continue;
    var getAllTask = repo.getAll(context).then(onFinishTask);
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  logger.i('Number of GameItem items: ${results.length}');
  var sorted = results.sortedBy((recipe) => recipe.title).toList();

  return ResultWithValue(results.length > 0, sorted, '');
}

Future<ResultWithValue<RecipeIngredientDetails>>
    getRecipeIngredientDetailsFuture(
        BuildContext context, RecipeIngredient recipeIngredient) async {
  var itemId = recipeIngredient.id;
  ResultWithValue<IGameItemJsonService> genRepo =
      getGameItemRepoFromId(context, itemId);
  if (genRepo.hasFailed)
    return ResultWithValue<RecipeIngredientDetails>(
        false,
        RecipeIngredientDetails(),
        'genericItemFuture - unknown type of item $itemId');

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
        '');
  }

  return ResultWithValue(false, null, itemResult.errorMessage);
}

Future<ResultWithValue<List<RecipeIngredientDetails>>>
    recipeIngredientDetailsFuture(
        context, List<RecipeIngredient> inputs) async {
  List<RecipeIngredientDetails> results = List<RecipeIngredientDetails>();

  List<Future<ResultWithValue<RecipeIngredientDetails>>> tasks =
      List<Future<ResultWithValue<RecipeIngredientDetails>>>();
  var onFinishTask = (ResultWithValue<RecipeIngredientDetails> ingResult) {
    if (ingResult.hasFailed || ingResult.value == null) return;
    results.add(ingResult.value);
  };
  for (RecipeIngredient input in inputs) {
    tasks.add(
      getRecipeIngredientDetailsFuture(context, input).then(onFinishTask),
    );
  }
  await Future.wait(tasks);

  // var sorted = results.sortedBy((recipe) => recipe.name).toList();

  return ResultWithValue(results.length > 0, results, '');
}

Future<ResultWithValue<List<CraftedUsing>>> craftingRecipesFuture(
    context, String itemId) async {
  List<CraftedUsing> results = List<CraftedUsing>();

  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    ResultWithValue<List<Recipe>> getOutput =
        await repo.getByOutputId(context, itemId);
    if (!getOutput.isSuccess) continue;
    for (Recipe recipe in getOutput.value) {
      List<Future<ResultWithValue<RecipeIngredientDetails>>> ingDetailsTask =
          List<Future<ResultWithValue<RecipeIngredientDetails>>>();
      for (var recipeIng in recipe.inputs) {
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

  return ResultWithValue(results.length > 0, results, '');
}

Future<ResultWithValue<List<UsedInRecipe>>> usedInRecipesFuture(
    context, String itemId) async {
  List<UsedInRecipe> results = List<UsedInRecipe>();
  var onFinishTask =
      (LocaleKey langJsonPath, ResultWithValue<List<Recipe>> result) {
    if (result.hasFailed || result.value == null || result.value.length == 0)
      return;
    results.add(
      UsedInRecipe(getDisplayNameFromLangFileName(langJsonPath), result.value),
    );
  };
  List<Future<ResultWithValue<List<Recipe>>>> tasks =
      List<Future<ResultWithValue<List<Recipe>>>>();
  for (LocaleKey repJson in allRecipeJsons()) {
    IRecipeJsonService repo = getRecipeRepo(repJson);
    if (repo == null) continue;
    var getAllTask = repo.getByInputsId(context, itemId).then(
          (ResultWithValue<List<Recipe>> result) =>
              onFinishTask(repJson, result),
        );
    tasks.add(getAllTask);
  }
  await Future.wait(tasks);

  // results.sortedBy((recipe) => recipe.name);

  return ResultWithValue(results.length > 0, results, '');
}
