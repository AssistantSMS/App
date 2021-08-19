import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
    currentWhatIsNewGuid: '8f0fe9ab-95d9-4029-aef1-f61cd0a1fda8',
    patreonOAuthClientId: patreonOAuthClientId,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp(env));
}
