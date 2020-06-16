import '../recipeIngredient/recipeIngredient.dart';
import 'recipeBase.dart';
import 'recipeLang.dart';

class Recipe {
  Recipe({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.inputs,
  });

  String id;
  String icon;
  String title;
  String description;
  List<RecipeIngredient> inputs;

  factory Recipe.fromBaseAndLang(RecipeBase baseItem, RecipeLang lang) =>
      Recipe(
        id: baseItem.id,
        icon: baseItem.icon,
        inputs: baseItem.inputs,
        title: lang.title,
        description: lang.description,
      );
}
