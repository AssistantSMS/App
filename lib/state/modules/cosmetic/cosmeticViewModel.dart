import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'actions.dart';
import 'selector.dart';

class CosmeticViewModel {
  List<String> owned;

  Function(String itemId) addToOwned;
  Function(String id) removeFromOwned;
  Function() removeAll;

  CosmeticViewModel({
    required this.owned,
    required this.addToOwned,
    required this.removeFromOwned,
    required this.removeAll,
  });

  static CosmeticViewModel fromStore(Store<AppState> store) {
    return CosmeticViewModel(
      owned: getOwned(store.state),
      addToOwned: (String itemId) => store.dispatch(AddCosmeticAction(itemId)),
      removeFromOwned: (String itemId) =>
          store.dispatch(RemoveCosmeticAction(itemId)),
      removeAll: () => store.dispatch(RemoveAllCosmeticAction()),
    );
  }
}
