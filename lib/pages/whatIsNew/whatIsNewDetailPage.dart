import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../helpers/analytics.dart';
import '../../integration/dependencyInjection.dart';

class WhatIsNewDetailPage extends StatelessWidget {
  final VersionViewModel version;

  WhatIsNewDetailPage(this.version) {
    trackEvent(AnalyticsEvent.whatIsNewDetailPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(this.version.buildName),
      ),
      body: WhatIsNewDetailPageComponent(
        getEnv().assistantAppsAppGuid,
        version,
      ),
    );
  }
}
