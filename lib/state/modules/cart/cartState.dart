import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../constants/HiveTypeConstant.dart';
import 'cartItemState.dart';

part 'cartState.g.dart';

@immutable
@HiveType(typeId: HiveTypeConstant.cartState)
class CartState {
  @HiveField(0)
  final List<CartItemState> items;

  CartState({
    this.items,
  });

  factory CartState.initial() {
    return CartState(
      items: List<CartItemState>(),
    );
  }

  CartState copyWith({
    List<CartItemState> items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}
