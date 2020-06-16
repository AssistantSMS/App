// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

class RecipeIngredientDetails {
  RecipeIngredientDetails({
    this.id,
    this.icon,
    this.title,
    this.description,
    this.quantity,
  });

  String id;
  String icon;
  String title;
  String description;
  int quantity;
}
