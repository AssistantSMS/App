import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../constants/HiveTypeConstant.dart';

part 'cartItemState.g.dart';

@immutable
@HiveType(typeId: HiveTypeConstant.cartItemState)
class CartItemState {
  @HiveField(0)
  final String itemId;
  @HiveField(1)
  final int quantity;

  CartItemState({
    this.itemId,
    this.quantity,
  });

  factory CartItemState.initial() {
    return CartItemState(
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
}
