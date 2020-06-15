import '../integration/logging.dart';
import 'modules/base/appState.dart';
import 'modules/setting/reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  logger.i(state);
  return AppState(
    settingState: settingReducer(state.settingState, action),
  );
}
