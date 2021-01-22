import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import 'modules/base/appState.dart';
import 'modules/cart/reducer.dart';
import 'modules/raid/reducer.dart';
import 'modules/cosmetic/reducer.dart';
import 'modules/setting/reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  getLog().i(state.toString());
  return AppState(
    settingState: settingReducer(state.settingState, action),
    cartState: cartReducer(state.cartState, action),
    raidState: raidReducer(state.raidState, action),
    cosmeticState: cosmeticReducer(state.cosmeticState, action),
  );
}
