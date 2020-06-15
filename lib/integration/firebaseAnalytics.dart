import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseAnalytics analytics;

void initFirebaseAnalytics() {
  analytics = FirebaseAnalytics();
}

Future firebaseTrackEvent(String key) async =>
    await analytics.logEvent(name: key);
// firebaseTrackEvent(String key) async {}
