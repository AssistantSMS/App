import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/bottomNavbar.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../helpers/analytics.dart';

class PatronListPage extends StatelessWidget {
  PatronListPage() {
    trackEvent(AnalyticsEvent.patronListPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.patrons)),
      ),
      body: PatronListPageComponent(),
      bottomNavigationBar: BottomNavbar(noRouteSelected: true),
    );
  }
}
