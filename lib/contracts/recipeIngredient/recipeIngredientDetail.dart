// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

import 'package:scrapmechanic_kurtlourens_com/localization/localeKey.dart';

class RecipeIngredientDetails {
  RecipeIngredientDetails({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.quantity,
    this.craftingStationName,
  });

  String id;
  String icon;
  String title;
  String description;
  int quantity;
  LocaleKey craftingStationName;
}
