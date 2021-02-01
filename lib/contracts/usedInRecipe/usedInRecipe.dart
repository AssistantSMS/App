import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../recipe/recipe.dart';

class UsedInRecipe {
  final LocaleKey name;
  final List<Recipe> recipes;

  UsedInRecipe(this.name, this.recipes);
}
