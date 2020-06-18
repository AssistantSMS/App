import 'package:flutter/material.dart';

import 'app.dart';
import 'env/environmentSettings.dart';

Future main() async {
  var env = EnvironmentSettings(
    baseApi: "https://api.scrapassistant.com",
    donationsEnabled: false,
    isProduction: true,
  );

  runApp(MyApp(env));
}
