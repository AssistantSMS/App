import 'package:flutter/material.dart';

import 'app.dart';
import 'assistantAppsSettings.dart';
import 'env.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    scrapAssistantApiUrl: "https://api.scrapassistant.com",
    assistantAppsApiUrl: assistantAppsApiUrl,
    donationsEnabled: false,
    isProduction: true,
    assistantAppsAppGuid: assistantAppsAppGuid,
    currentWhatIsNewGuid: currentWhatIsNewGuid,
    patreonOAuthClientId: patreonOAuthClientId,
  );

  runApp(AssistantSMS(env));
}
