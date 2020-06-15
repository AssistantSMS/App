import '../recipeIngredient/recipeIngredient.dart';
import 'recipeBase.dart';
import 'recipeLang.dart';

class Recipe {
  Recipe({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.ingredients,
  });

  String id;
  String icon;
  String title;
  String description;
  List<RecipeIngredient> ingredients;

  factory Recipe.fromBaseAndLang(RecipeBase baseItem, RecipeLang lang) =>
      Recipe(
        id: baseItem.id,
        icon: baseItem.icon,
        ingredients: baseItem.ingredients,
        title: lang.title,
        description: lang.description,
      );
}
