import 'package:dartx/dartx.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'cosmeticState.dart';

final cosmeticReducer = combineReducers<CosmeticState>([
  TypedReducer<CosmeticState, AddCosmeticAction>(_addCraftingToCart),
  TypedReducer<CosmeticState, RemoveCosmeticAction>(_removeCraftingFromCart),
  TypedReducer<CosmeticState, RemoveAllCosmeticAction>(
      _removeAllCraftingFromCart),
]);

CosmeticState _addCraftingToCart(
    CosmeticState state, AddCosmeticAction action) {
  if (state.owned.any((own) => own == action.itemId)) return state;

  List<String> newItems = state.owned;
  newItems.add(action.itemId);

  return state.copyWith(owned: newItems);
}

CosmeticState _removeCraftingFromCart(
    CosmeticState state, RemoveCosmeticAction action) {
  String? itemToDelete = state.owned //
      .firstOrNullWhere((ci) => ci == action.itemId);
  if (itemToDelete == null) return state;

  return state.copyWith(owned: List.from(state.owned)..remove(itemToDelete));
}

CosmeticState _removeAllCraftingFromCart(
    CosmeticState state, RemoveAllCosmeticAction action) {
  return state.copyWith(owned: List.empty(growable: true));
}
