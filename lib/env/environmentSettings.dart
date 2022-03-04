import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class EnvironmentSettings {
  String scrapAssistantApiUrl;
  String assistantAppsApiUrl;
  bool donationsEnabled;
  bool isProduction;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;
  String patreonOAuthClientId;

  EnvironmentSettings({
    @required this.scrapAssistantApiUrl,
    @required this.assistantAppsApiUrl,
    @required this.donationsEnabled,
    @required this.isProduction,
    @required this.assistantAppsAppGuid,
    @required this.currentWhatIsNewGuid,
    @required this.patreonOAuthClientId,
  });

  AssistantAppsEnvironmentSettings toAssistantApps() =>
      AssistantAppsEnvironmentSettings(
        assistantAppsAppGuid: assistantAppsAppGuid,
        currentWhatIsNewGuid: currentWhatIsNewGuid,
        isProduction: isProduction,
        patreonOAuthClientId: patreonOAuthClientId,
      );
}
