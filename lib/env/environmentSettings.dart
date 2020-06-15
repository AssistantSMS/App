import 'package:flutter/material.dart';

class EnvironmentSettings {
  String baseApi;
  bool donationsEnabled;
  bool isProduction;

  EnvironmentSettings({
    @required this.baseApi,
    @required this.donationsEnabled,
    @required this.isProduction,
  });
}
