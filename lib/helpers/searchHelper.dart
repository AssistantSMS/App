import '../contracts/gameItem/gameItem.dart';
import '../contracts/recipe/recipe.dart';

bool searchRecipe(Recipe recipe, String search) =>
    recipe.title.toLowerCase().contains(search.toLowerCase());

bool searchGameItem(GameItem gameItem, String search) =>
    gameItem.title.toLowerCase().contains(search.toLowerCase());
