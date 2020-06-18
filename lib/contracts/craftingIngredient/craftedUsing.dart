import '../../localization/localeKey.dart';
import '../recipeIngredient/recipeIngredientDetail.dart';

class CraftedUsing {
  final LocaleKey name;
  final List<RecipeIngredientDetails> ingredientDetails;

  CraftedUsing(this.name, this.ingredientDetails);
}
