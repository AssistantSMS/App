import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    scrapAssistantApiUrl: "https://staging-api.scrapassistant.com",
    assistantAppsApiUrl: "https://api.assistantapps.com",
    donationsEnabled: false,
    isProduction: false,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp(env));
}
