import 'package:redux/redux.dart';

import 'actions.dart';
import 'cartItemState.dart';
import 'cartState.dart';

final cartReducer = combineReducers<CartState>([
  TypedReducer<CartState, AddCraftingToCartAction>(_addCraftingToCart),
  TypedReducer<CartState, EditCraftingToCartAction>(_editCraftingItemInCart),
  TypedReducer<CartState, RemoveCraftingFromCartAction>(
      _removeCraftingFromCart),
  TypedReducer<CartState, RemoveAllCraftingFromCartAction>(
      _removeAllCraftingFromCart),
]);

CartState _addCraftingToCart(CartState state, AddCraftingToCartAction action) {
  bool addedNewItem = false;
  List<CartItemState> newItems = List.empty(growable: true);
  for (var craftingIndex = 0;
      craftingIndex < state.items.length;
      craftingIndex++) {
    int quantity = state.items[craftingIndex].quantity;
    if (state.items[craftingIndex].itemId == action.itemId) {
      addedNewItem = true;
      quantity = quantity + action.quantity;
    }
    newItems.add(CartItemState(
      itemId: state.items[craftingIndex].itemId,
      quantity: quantity,
    ));
  }
  if (!addedNewItem) {
    newItems.add(CartItemState(
      itemId: action.itemId,
      quantity: action.quantity,
    ));
  }
  return state.copyWith(items: newItems);
}

CartState _editCraftingItemInCart(
    CartState state, EditCraftingToCartAction action) {
  List<CartItemState> newItems = List.empty(growable: true);
  for (var craftingIndex = 0;
      craftingIndex < state.items.length;
      craftingIndex++) {
    int quantity = state.items[craftingIndex].quantity;
    if (state.items[craftingIndex].itemId == action.itemId) {
      quantity = action.quantity;
    }
    newItems.add(CartItemState(
      itemId: state.items[craftingIndex].itemId,
      quantity: quantity,
    ));
  }
  return state.copyWith(items: newItems);
}

CartState _removeCraftingFromCart(
    CartState state, RemoveCraftingFromCartAction action) {
  CartItemState oldCardItem =
      state.items.firstWhere((ci) => ci.itemId == action.id);
  if (oldCardItem == null) return state;

  return state.copyWith(items: List.from(state.items)..remove(oldCardItem));
}

CartState _removeAllCraftingFromCart(
    CartState state, RemoveAllCraftingFromCartAction action) {
  return state.copyWith(items: List.empty(growable: true));
}
