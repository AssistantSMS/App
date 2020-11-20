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
    currentWhatIsNewGuid: '47f1a804-2ade-4f3a-a91e-edf997f32af5',
  );

  runApp(MyApp(env));
}
