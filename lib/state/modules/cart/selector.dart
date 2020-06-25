import '../base/appState.dart';
import 'cartItemState.dart';

List<CartItemState> getCartItems(AppState state) =>
    state?.cartState?.items ?? List<CartItemState>();
