import '../recipeIngredient/recipeIngredient.dart';
import 'recipeBase.dart';
import 'recipeLang.dart';

class Recipe {
  Recipe({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.output,
    this.inputs,
  });

  String id;
  String icon;
  String title;
  String description;
  RecipeIngredient output;
  List<RecipeIngredient> inputs;

  factory Recipe.fromBaseAndLang(RecipeBase baseItem, RecipeLang lang) =>
      Recipe(
        id: baseItem.id,
        icon: baseItem.icon,
        output: baseItem.output,
        inputs: baseItem.inputs,
        title: lang.title,
        description: lang.description,
      );
}
