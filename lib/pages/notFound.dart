import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  // NotFoundPage() {
  //   getAnalytics().trackEvent(AnalyticsEvent.aboutPage);
  // }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text('Not Found'),
      ),
      body: Center(child: Text('Not Found')),
    );
  }
}
