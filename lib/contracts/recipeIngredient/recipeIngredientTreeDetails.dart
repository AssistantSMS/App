import './recipeIngredientDetail.dart';

class RecipeIngredientTreeDetails extends RecipeIngredientDetails {
  int cost;
  List<RecipeIngredientTreeDetails> children;

  RecipeIngredientTreeDetails({
    id,
    icon,
    title,
    quantity,
    required this.cost,
    required this.children,
  }) : super(
          id: id,
          title: title,
          icon: icon,
          quantity: quantity,
        );

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
