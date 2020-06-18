import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'actions.dart';
import 'cartItemState.dart';
import 'selector.dart';

class CartViewModel {
  List<CartItemState> craftingItems;
  final bool displayGenericItemColour;

  Function(String itemId, int quantity) addToCart;
  Function(String itemId, int quantity) editCartItem;
  Function(String id) removeFromCart;
  Function() removeAllFromCart;

  CartViewModel(
      {this.craftingItems,
      this.displayGenericItemColour,
      this.addToCart,
      this.editCartItem,
      this.removeAllFromCart,
      this.removeFromCart});

  static CartViewModel fromStore(Store<AppState> store) {
    return CartViewModel(
        craftingItems: getCartItems(store.state),
        addToCart: (String itemId, int quantity) =>
            store.dispatch(AddCraftingToCartAction(itemId, quantity)),
        editCartItem: (String itemId, int quantity) =>
            store.dispatch(EditCraftingToCartAction(itemId, quantity)),
        removeFromCart: (String id) =>
            store.dispatch(RemoveCraftingFromCartAction(id)),
        removeAllFromCart: () =>
            store.dispatch(RemoveAllCraftingFromCartAction()));
  }
}
