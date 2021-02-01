import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService implements IAnalyticsService {
  FirebaseAnalytics analytics;
  AnalyticsService() {
    analytics = FirebaseAnalytics();
  }

  void trackEvent(String key, {dynamic data}) {
    if (kReleaseMode) {
      analytics.logEvent(name: key);
    } else {
      getLog().v("[Analytics]: $key----");
    }
  }
}
