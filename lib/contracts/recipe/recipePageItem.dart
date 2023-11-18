import '../recipeIngredient/recipeIngredientDetail.dart';
import 'recipe.dart';

class RecipePageItem {
  Recipe recipe;
  List<RecipeIngredientDetails> ingredientDetails;

  RecipePageItem({
    required this.recipe,
    required this.ingredientDetails,
  });

  factory RecipePageItem.initial() => RecipePageItem(
        recipe: Recipe.initial(),
        ingredientDetails: List.empty(),
      );
}
