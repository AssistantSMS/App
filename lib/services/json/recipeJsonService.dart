import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipe/recipeBase.dart';
import '../../contracts/recipe/recipeLang.dart';
import '../../mapper/recipeMapper.dart';
import './interface/IRecipeJsonService.dart';

class RecipeJsonService extends BaseJsonService implements IRecipeJsonService {
  String baseJson;
  LocaleKey detailsJsonLocale;
  RecipeJsonService(this.baseJson, this.detailsJsonLocale);
  //
  @override
  Future<ResultWithValue<List<Recipe>>> getAll(context) async {
    String detailJson = getTranslations().fromKey(detailsJsonLocale);
    try {
      List responseJson = await this.getListfromJson(context, baseJson);
      List responseDetailsJson =
          await this.getListfromJson(context, detailJson);
      List<RecipeBase> baseItems =
          responseJson.map((m) => RecipeBase.fromJson(m)).toList();
      List<RecipeLang> detailedItems =
          responseDetailsJson.map((m) => RecipeLang.fromJson(m)).toList();

      return ResultWithValue<List<Recipe>>(
          true, mapRecipeItems(context, baseItems, detailedItems), '');
    } catch (exception) {
      getLog().e(
          "RecipeJsonRepo($baseJson, $detailJson) Exception: ${exception.toString()}");
      return ResultWithValue<List<Recipe>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<Recipe>> getById(context, String id) async {
    ResultWithValue<List<Recipe>> allRecipesResult = await this.getAll(context);
    if (allRecipesResult.hasFailed) {
      return ResultWithValue(false, Recipe(), allRecipesResult.errorMessage);
    }
    try {
      Recipe selectedRecipe =
          allRecipesResult.value.firstWhere((r) => r.id == id);
      return ResultWithValue<Recipe>(true, selectedRecipe, '');
    } catch (exception) {
      getLog()
          .e("RecipeJsonRepo($baseJson) Exception: ${exception.toString()}");
      return ResultWithValue<Recipe>(false, Recipe(), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<List<Recipe>>> getByInputsId(
      context, String id) async {
    ResultWithValue<List<Recipe>> allRecipesResult = await this.getAll(context);
    if (allRecipesResult.hasFailed) {
      return ResultWithValue(
          false, List.empty(growable: true), allRecipesResult.errorMessage);
    }
    try {
      var recipeInputs = allRecipesResult.value
          .where((r) => r.inputs.any((ri) => ri.id == id))
          .toList();
      return ResultWithValue<List<Recipe>>(true, recipeInputs, '');
    } catch (exception) {
      getLog()
          .e("RecipeJsonRepo($baseJson) Exception: ${exception.toString()}");
      return ResultWithValue<List<Recipe>>(
          false, List.empty(growable: true), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<List<Recipe>>> getByOutputId(
      context, String id) async {
    ResultWithValue<List<Recipe>> allRecipesResult = await this.getAll(context);
    if (allRecipesResult.hasFailed) {
      return ResultWithValue(
          false, List.empty(growable: true), allRecipesResult.errorMessage);
    }
    try {
      var recipeInputs = allRecipesResult.value
          .where((r) =>
              r.output != null && r.output.id != null && r.output.id != '')
          .where((r) => r.output.id == id)
          .toList();
      return ResultWithValue<List<Recipe>>(true, recipeInputs, '');
    } catch (exception) {
      getLog()
          .e("RecipeJsonRepo($baseJson) Exception: ${exception.toString()}");
      return ResultWithValue<List<Recipe>>(
          false, List.empty(growable: true), exception.toString());
    }
  }
}
