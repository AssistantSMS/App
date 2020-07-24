import '../integration/logging.dart';
import 'modules/base/appState.dart';
import 'modules/cart/reducer.dart';
import 'modules/raid/reducer.dart';
import 'modules/setting/reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  logger.i(state);
  return AppState(
    settingState: settingReducer(state.settingState, action),
    cartState: cartReducer(state.cartState, action),
    raidState: raidReducer(state.raidState, action),
  );
}
