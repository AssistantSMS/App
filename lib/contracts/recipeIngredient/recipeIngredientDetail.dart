// To parse this JSON data, do
//
//     final recipeIngredient = recipeIngredientFromJson(jsonString);

class RecipeIngredientDetails {
  RecipeIngredientDetails({
    this.id,
    this.title,
    this.description,
    this.quantity,
  });

  String id;
  String title;
  String description;
  int quantity;
}
