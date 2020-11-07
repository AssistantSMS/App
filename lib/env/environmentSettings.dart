import 'package:flutter/material.dart';

class EnvironmentSettings {
  String scrapAssistantApiUrl;
  String assistantAppsApiUrl;
  bool donationsEnabled;
  bool isProduction;
  String assistantAppsAppGuid;
  String currentWhatIsNewGuid;

  EnvironmentSettings({
    @required this.scrapAssistantApiUrl,
    @required this.assistantAppsApiUrl,
    @required this.donationsEnabled,
    @required this.isProduction,
    @required this.assistantAppsAppGuid,
    @required this.currentWhatIsNewGuid,
  });
}
