import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../state/modules/base/appState.dart';
import '../state/modules/setting/settingState.dart';
import 'logging.dart';

Future initHiveState() async {
  logger.d('Hive Web initialize');
  await Hive.initFlutter('hive');
  registerAdapters();
}

registerAdapters() {
  Hive.registerAdapter(AppStateAdapter());
  Hive.registerAdapter(SettingStateAdapter());
}

Future closeHiveState() async {
  await Hive.close();
}
