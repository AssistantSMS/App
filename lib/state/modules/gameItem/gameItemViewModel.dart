import 'package:redux/redux.dart';

import '../base/appState.dart';
import '../cart/actions.dart';
import '../cart/cartItemState.dart';
import '../cart/selector.dart';

class GameItemViewModel {
  List<CartItemState> cartItems;

  Function(String itemId, int quantity) addToCart;
  Function(String itemId, int quantity) editCartItem;
  Function(String id) removeFromCart;

  GameItemViewModel({
    this.cartItems,
    this.addToCart,
    this.editCartItem,
    this.removeFromCart,
  });

  static GameItemViewModel fromStore(Store<AppState> store) {
    return GameItemViewModel(
      cartItems: getCartItems(store.state),
      addToCart: (String itemId, int quantity) =>
          store.dispatch(AddCraftingToCartAction(itemId, quantity)),
      editCartItem: (String itemId, int quantity) =>
          store.dispatch(EditCraftingToCartAction(itemId, quantity)),
      removeFromCart: (String id) =>
          store.dispatch(RemoveCraftingFromCartAction(id)),
    );
  }
}
