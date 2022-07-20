import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'app.dart';
import 'assistantAppsSettings.dart';
import 'env.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    // baseApi: "https://localhost:44320",
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    // assistantAppsApiUrl: "http://localhost:55555",
    assistantAppsApiUrl: assistantAppsApiUrl,
    donationsEnabled: true,
    isProduction: false,
    assistantAppsAppGuid: assistantAppsAppGuid,
    currentWhatIsNewGuid: currentWhatIsNewGuid,
    patreonOAuthClientId: patreonOAuthClientId,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(AssistantSMS(env));

  if (isWindows) {
    doWhenWindowReady(() {
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
}
