import '../../localization/localeKey.dart';
import '../recipe/recipe.dart';

class UsedInRecipe {
  final LocaleKey name;
  final List<Recipe> recipes;

  UsedInRecipe(this.name, this.recipes);
}
