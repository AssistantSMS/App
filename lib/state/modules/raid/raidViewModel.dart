import 'package:redux/redux.dart';

import '../base/appState.dart';
import 'actions.dart';
import 'selector.dart';

class RaidViewModel {
  int carrot;
  int tomato;
  int beetroot;
  int banana;
  int berry;
  int orange;
  int potato;
  int pineapple;
  int broccoli;
  int cotton;

  Function({
    int? carrot,
    int? tomato,
    int? beetroot,
    int? banana,
    int? berry,
    int? orange,
    int? potato,
    int? pineapple,
    int? broccoli,
    int? cotton,
  }) editRaidItem;

  RaidViewModel({
    required this.carrot,
    required this.tomato,
    required this.beetroot,
    required this.banana,
    required this.berry,
    required this.orange,
    required this.potato,
    required this.pineapple,
    required this.broccoli,
    required this.cotton,
    required this.editRaidItem,
  });

  static RaidViewModel fromStore(Store<AppState> store) {
    return RaidViewModel(
      carrot: getCarrot(store.state),
      tomato: getTomato(store.state),
      beetroot: getBeetroot(store.state),
      banana: getBanana(store.state),
      berry: getBerry(store.state),
      orange: getOrange(store.state),
      potato: getPotato(store.state),
      pineapple: getPineapple(store.state),
      broccoli: getBroccoli(store.state),
      cotton: getCotton(store.state),
      editRaidItem: ({
        int? carrot,
        int? tomato,
        int? beetroot,
        int? banana,
        int? berry,
        int? orange,
        int? potato,
        int? pineapple,
        int? broccoli,
        int? cotton,
      }) =>
          store.dispatch(
        EditRaidAction(
          carrot,
          tomato,
          beetroot,
          banana,
          berry,
          orange,
          potato,
          pineapple,
          broccoli,
          cotton,
        ),
      ),
    );
  }
}
