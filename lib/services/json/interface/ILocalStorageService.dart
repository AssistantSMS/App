import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

import '../../../state/modules/base/appState.dart';
import '../../../state/themeState.dart';

class ILocalStorageService {
  Future<Result> saveAppState(AppState state) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<AppState>> loadAppState() async =>
      ResultWithValue<AppState>(false, AppState.initial(), 'Not Implemented');

  Future<Result> saveThemeState(ThemeState state) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<ThemeState>> loadThemeState() async =>
      ResultWithValue<ThemeState>(
          false, ThemeState('failed'), 'Not Implemented');
}
