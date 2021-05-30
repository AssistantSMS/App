import 'package:flutter/material.dart';

import 'app.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    assistantAppsApiUrl: "https://api.assistantapps.com",
    donationsEnabled: false,
    isProduction: true,
    assistantAppsAppGuid: 'dfe0dbc7-8df4-47fb-a5a5-49af1937c4e2',
    currentWhatIsNewGuid: '8f0fe9ab-95d9-4029-aef1-f61cd0a1fda8',
  );

  runApp(MyApp(env));
}
