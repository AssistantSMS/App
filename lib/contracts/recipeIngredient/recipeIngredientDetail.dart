// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class RecipeIngredientDetails {
  String id;
  String? icon;
  String title;
  int quantity;
  String? description;
  LocaleKey? craftingStationName;

  RecipeIngredientDetails({
    required this.id,
    required this.icon,
    required this.title,
    required this.quantity,
    this.description,
    this.craftingStationName,
  });

  factory RecipeIngredientDetails.initial() => RecipeIngredientDetails(
        id: '',
        icon: '',
        title: '',
        quantity: 0,
      );
}
