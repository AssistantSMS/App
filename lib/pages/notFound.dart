import 'package:flutter/material.dart';

import '../components/adaptive/appBarForSubPage.dart';
import '../components/adaptive/appScaffold.dart';

class NotFoundPage extends StatelessWidget {
  // NotFoundPage() {
  //   trackEvent(AnalyticsEvent.aboutPage);
  // }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text('Not Found'),
      ),
      body: Center(child: Text('Not Found')),
    );
  }
}
