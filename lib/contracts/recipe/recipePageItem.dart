import '../recipeIngredient/recipeIngredientDetail.dart';
import 'recipe.dart';

class RecipePageItem {
  RecipePageItem({
    this.recipe,
    this.ingredientDetails,
  });

  Recipe recipe;
  List<RecipeIngredientDetails> ingredientDetails;
}
