import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../recipeIngredient/recipeIngredientDetail.dart';

class CraftedUsing {
  final LocaleKey name;
  final List<RecipeIngredientDetails> ingredientDetails;

  CraftedUsing(this.name, this.ingredientDetails);
}
