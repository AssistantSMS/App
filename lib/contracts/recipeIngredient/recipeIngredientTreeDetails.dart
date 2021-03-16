import './recipeIngredientDetail.dart';

class RecipeIngredientTreeDetails extends RecipeIngredientDetails {
  int cost;
  List<RecipeIngredientTreeDetails> children;

  RecipeIngredientTreeDetails({id, icon, title, cost, quantity, children}) {
    this.id = id;
    this.title = title;
    this.icon = icon;
    this.cost = cost;
    this.quantity = quantity;
    this.children = children;
  }

  factory RecipeIngredientTreeDetails.fromRequiredItemDetails(
      RecipeIngredientDetails req, int cost) {
    List<RecipeIngredientTreeDetails> children = List.empty(growable: true);
    return RecipeIngredientTreeDetails(
      id: req.id,
      icon: req.icon,
      title: req.title,
      cost: cost,
      quantity: req.quantity,
      children: children,
    );
  }

  @override
  String toString() {
    return "${quantity}x $title";
  }
}
