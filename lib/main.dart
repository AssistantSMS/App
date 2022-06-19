import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'app.dart';
import 'env.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    // baseApi: "https://localhost:44320",
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    // assistantAppsApiUrl: "http://localhost:55555",
    assistantAppsApiUrl: "https://api.assistantapps.com",
    donationsEnabled: true,
    isProduction: false,
    assistantAppsAppGuid: 'dfe0dbc7-8df4-47fb-a5a5-49af1937c4e2',
    currentWhatIsNewGuid: '8e27db59-4601-4952-80e9-3abe8cecf6cf',
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
