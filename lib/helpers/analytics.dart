import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';

import '../integration/firebaseAnalytics.dart';

trackEvent(String key) {
  if (kReleaseMode) {
    firebaseTrackEvent(key);
  } else {
    getLog().v("[Analytics]: $key");
  }
}
