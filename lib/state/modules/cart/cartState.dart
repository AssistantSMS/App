import 'package:meta/meta.dart';

import 'cartItemState.dart';

@immutable
class CartState {
  final List<CartItemState> items;

  CartState({
    this.items,
  });

  factory CartState.initial() {
    return CartState(
      items: List.empty(growable: true),
    );
  }

  CartState copyWith({
    List<CartItemState> items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  CartState.fromJson(Map<String, dynamic> json)
      : items = List<CartItemState>.from(
            json["items"].map((x) => CartItemState.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'items': items,
      };
}
