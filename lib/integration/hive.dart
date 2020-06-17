import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../state/modules/base/appState.dart';
import '../state/modules/setting/settingState.dart';
import 'logging.dart';

Future<void> initHiveState() async {
  try {
    logger.d('Hive Web initialize');
    await Hive.initFlutter('hive');
  } catch (exception) {
    logger.d('Hive Non - Web initialize');
    Hive.init('desktop');
  }
  registerAdapters();
}

registerAdapters() {
  Hive.registerAdapter(AppStateAdapter());
  Hive.registerAdapter(SettingStateAdapter());
}

Future<void> closeHiveState() async {
  await Hive.close();
}
