import 'package:redux/redux.dart';

import '../base/appState.dart';
import '../cart/actions.dart';
import '../cart/cartItemState.dart';
import '../cart/selector.dart';

class GameItemViewModel {
  List<CartItemState> cartItems;

  Function(String itemId, int quantity) addToCart;

  GameItemViewModel({
    this.cartItems,
    this.addToCart,
  });

  static GameItemViewModel fromStore(Store<AppState> store) {
    return GameItemViewModel(
      cartItems: getCartItems(store.state),
      addToCart: (String itemId, int quantity) =>
          store.dispatch(AddCraftingToCartAction(itemId, quantity)),
    );
  }
}
