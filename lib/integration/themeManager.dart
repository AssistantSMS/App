import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:theme_mode_handler/theme_mode_manager_interface.dart';

import '../state/themeState.dart';
import 'dependencyInjection.dart';

class ThemeManager implements IThemeModeManager {
  @override
  Future<String> loadThemeMode() async {
    ResultWithValue<ThemeState> themeResult =
        await getStorageService().loadThemeState();
    var defaultThemeMode = 'ThemeMode.dark';
    if (themeResult.isSuccess) {
      return themeResult?.value?.themeMode ?? defaultThemeMode;
    }
    return defaultThemeMode;
  }

  @override
  Future<bool> saveThemeMode(String value) async {
    var result = await getStorageService().saveThemeState(ThemeState(value));
    return result.isSuccess;
  }
}
