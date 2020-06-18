// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItemState.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemStateAdapter extends TypeAdapter<CartItemState> {
  @override
  final typeId = 4;

  @override
  CartItemState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemState(
      itemId: fields[0] as String,
      quantity: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.quantity);
  }
}
