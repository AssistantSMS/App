import 'package:flutter/foundation.dart';

import '../integration/firebaseAnalytics.dart';
import '../integration/logging.dart';

trackEvent(String key) {
  if (kReleaseMode) {
    firebaseTrackEvent(key);
  } else {
    logger.v("[Analytics]: $key");
  }
}
