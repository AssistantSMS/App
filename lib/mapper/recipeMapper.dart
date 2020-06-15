import '../contracts/recipe/recipe.dart';
import '../contracts/recipe/recipeBase.dart';
import '../contracts/recipe/recipeLang.dart';

List<Recipe> mapRecipeItems(
    context, List<RecipeBase> baseItems, List<RecipeLang> details) {
  List<Recipe> result = List<Recipe>();

  for (var baseIndex = 0; baseIndex < baseItems.length; baseIndex++) {
    var base = baseItems[baseIndex];
    var detail = details[baseIndex];
    if (base.id == null) continue;
    if (base.id == detail.id) {
      result.add(Recipe.fromBaseAndLang(base, detail));
      continue;
    } else {
      for (var detail in details) {
        if (base.id == detail.id) {
          result.add(Recipe.fromBaseAndLang(base, detail));
          break;
        }
      }
    }
  }

  return result;
}
