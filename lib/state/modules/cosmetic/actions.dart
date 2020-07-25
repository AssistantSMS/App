import '../base/persistToStorage.dart';

class AddCosmeticAction extends PersistToStorage {
  final String itemId;
  AddCosmeticAction(this.itemId);
}

class RemoveCosmeticAction extends PersistToStorage {
  final String itemId;
  RemoveCosmeticAction(this.itemId);
}

class RemoveAllCosmeticAction extends PersistToStorage {
  RemoveAllCosmeticAction();
}
