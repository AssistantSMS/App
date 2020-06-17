import 'package:flutter/foundation.dart';

import '../integration/firebaseAnalytics.dart';
import '../integration/logging.dart';
import 'deviceHelper.dart';

trackEvent(String key) {
  if (kReleaseMode && !isWeb) {
    firebaseTrackEvent(key);
  } else {
    logger.v("[Analytics]: $key");
  }
}
