import '../base/persistToStorage.dart';

class AddCraftingToCartAction extends PersistToStorage {
  final String itemId;
  final int quantity;
  AddCraftingToCartAction(this.itemId, this.quantity);
}

class EditCraftingToCartAction extends PersistToStorage {
  final String itemId;
  final int quantity;
  EditCraftingToCartAction(this.itemId, this.quantity);
}

class RemoveCraftingFromCartAction extends PersistToStorage {
  final String id;
  RemoveCraftingFromCartAction(this.id);
}

class RemoveAllCraftingFromCartAction extends PersistToStorage {
  RemoveAllCraftingFromCartAction();
}
