import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'assistantAppsSettings.dart';
import 'env.dart';
import 'env/environment_settings.dart';

Future main() async {
  var env = EnvironmentSettings(
    scrapAssistantApiUrl: "https://staging-api.scrapassistant.com",
    assistantAppsApiUrl: assistantAppsApiUrl,
    donationsEnabled: false,
    isProduction: false,
    assistantAppsAppGuid: assistantAppsAppGuid,
    currentWhatIsNewGuid: currentWhatIsNewGuid,
    patreonOAuthClientId: patreonOAuthClientId,
  );

  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  runApp(AssistantSMS(env));
}
