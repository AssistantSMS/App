import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../recipeIngredient/recipeIngredientDetail.dart';

class PackedUsing {
  final LocaleKey template;
  final RecipeIngredientDetails outputDetails;
  final List<RecipeIngredientDetails> ingredientDetails;

  PackedUsing(this.template, this.outputDetails, this.ingredientDetails);
}
