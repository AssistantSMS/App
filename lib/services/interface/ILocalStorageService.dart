import '../../contracts/results/result.dart';
import '../../contracts/results/resultWithValue.dart';
import '../../state/modules/base/appState.dart';
import '../../state/themeState.dart';

class ILocalStorageService {
  Future<Result> saveAppState(AppState state) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<AppState>> loadAppState() async =>
      ResultWithValue<AppState>(false, null, 'Not Implemented');

  Future<Result> saveThemeState(ThemeState state) async =>
      Result(false, 'Not Implemented');

  Future<ResultWithValue<ThemeState>> loadThemeState() async =>
      ResultWithValue<ThemeState>(false, null, 'Not Implemented');
}
