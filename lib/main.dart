import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
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
    currentWhatIsNewGuid: 'a67cbaba-3a36-4263-9d7e-7768b0f5654f',
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp(env));
}
