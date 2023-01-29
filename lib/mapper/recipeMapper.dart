import 'package:flutter/material.dart';

import '../contracts/recipe/recipe.dart';
import '../contracts/recipe/recipeBase.dart';
import '../contracts/recipe/recipeLang.dart';

List<Recipe> mapRecipeItems(
  BuildContext context,
  List<RecipeBase> baseItems,
  List<RecipeLang> details,
) {
  List<Recipe> result = List.empty(growable: true);

  for (var baseIndex = 0; baseIndex < baseItems.length; baseIndex++) {
    RecipeBase base = baseItems[baseIndex];
    RecipeLang detail = details[baseIndex];

    if (base.id == detail.id) {
      result.add(Recipe.fromBaseAndLang(base, detail));
      continue;
    } else {
      for (var detail in details) {
        if (base.id == detail.id) {
          result.add(Recipe.fromBaseAndLang(base, detail));
          break;
        }
      }
    }
  }

  return result;
}
