import 'package:flutter/material.dart';

import 'app.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    assistantAppsApiUrl: "https://api.assistantapps.com",
    donationsEnabled: false,
    isProduction: true,
  );

  runApp(MyApp(env));
}
