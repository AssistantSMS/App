import '../../contracts/recipe/recipe.dart';
import '../../contracts/recipe/recipeBase.dart';
import '../../contracts/recipe/recipeLang.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../mapper/recipeMapper.dart';
import '../BaseJsonService.dart';
import '../interface/IRecipeJsonService.dart';

class RecipeJsonService extends BaseJsonService implements IRecipeJsonService {
  String baseJson;
  LocaleKey detailsJsonLocale;
  RecipeJsonService(this.baseJson, this.detailsJsonLocale);
  //
  @override
  Future<ResultWithValue<List<Recipe>>> getAll(context) async {
    String detailJson = Translations.get(context, detailsJsonLocale);
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
      print(
          "RecipeJsonRepo($baseJson, $detailJson) Exception: ${exception.toString()}");
      return ResultWithValue<List<Recipe>>(
          false, List<Recipe>(), exception.toString());
    }
  }

  @override
  Future<ResultWithValue<Recipe>> getById(context, String id) async {
    ResultWithValue<List<Recipe>> allGenericItemsResult =
        await this.getAll(context);
    if (allGenericItemsResult.hasFailed) {
      return ResultWithValue(
          false, Recipe(), allGenericItemsResult.errorMessage);
    }
    try {
      Recipe selectedGeneric =
          allGenericItemsResult.value.firstWhere((r) => r.id == id);
      return ResultWithValue<Recipe>(true, selectedGeneric, '');
    } catch (exception) {
      print("RecipeJsonRepo($baseJson) Exception: ${exception.toString()}");
      return ResultWithValue<Recipe>(false, Recipe(), exception.toString());
    }
  }
}
