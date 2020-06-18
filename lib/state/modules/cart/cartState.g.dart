// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartState.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartStateAdapter extends TypeAdapter<CartState> {
  @override
  final typeId = 3;

  @override
  CartState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartState(
      items: (fields[0] as List)?.cast<CartItemState>(),
    );
  }

  @override
  void write(BinaryWriter writer, CartState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.items);
  }
}
