import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';

import '../../integration/firebaseAnalytics.dart';

class AnalyticsService implements IAnalyticsService {
  void trackEvent(String key, {dynamic data}) {
    if (kReleaseMode) {
      firebaseTrackEvent(key);
    } else {
      getLog().v("[Analytics]: $key----");
    }
  }
}
