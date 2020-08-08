import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    // baseApi: "https://localhost:44320",
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    assistantAppsApiUrl: "http://localhost:55555",
    donationsEnabled: true,
    isProduction: false,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(MyApp(env));
}
