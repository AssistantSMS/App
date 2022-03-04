import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:meta/meta.dart';

@immutable
class CartItemState {
  final String itemId;
  final int quantity;

  const CartItemState({
    this.itemId,
    this.quantity,
  });

  factory CartItemState.initial() {
    return const CartItemState(
      itemId: '',
      quantity: 0,
    );
  }

  CartItemState copyWith({
    String itemId,
    int quantity,
  }) {
    return CartItemState(
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
    );
  }

  CartItemState.fromJson(Map<String, dynamic> json)
      : itemId = readStringSafe(json, 'itemId'),
        quantity = readIntSafe(json, 'quantity');

  Map<String, dynamic> toJson() => {
        'itemId': itemId,
        'quantity': quantity,
      };
}
