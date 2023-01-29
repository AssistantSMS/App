import '../recipeIngredient/recipeIngredient.dart';
import 'recipeBase.dart';
import 'recipeLang.dart';

class Recipe {
  String id;
  String icon;
  String title;
  int craftingTime;
  String description;
  RecipeIngredient output;
  List<RecipeIngredient> inputs;

  Recipe({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.craftingTime,
    required this.output,
    required this.inputs,
  });

  factory Recipe.initial() => Recipe(
        id: '',
        icon: '',
        title: '',
        description: '',
        craftingTime: 0,
        output: RecipeIngredient.initial(),
        inputs: List.empty(),
      );

  factory Recipe.fromBaseAndLang(RecipeBase baseItem, RecipeLang lang) =>
      Recipe(
        id: baseItem.id,
        icon: baseItem.icon,
        output: baseItem.output,
        inputs: baseItem.inputs,
        craftingTime: baseItem.craftingTime,
        title: lang.title,
        description: lang.description,
      );
}
