import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../helpers/analytics.dart';
import '../../integration/dependencyInjection.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/setting/whatIsNewSettingsViewModel.dart';
import 'whatIsNewDetailPage.dart';

class WhatIsNewPage extends StatefulWidget {
  WhatIsNewPage({Key key}) : super(key: key) {
    trackEvent(AnalyticsEvent.whatIsNewPage);
  }

  @override
  _WhatIsNewWidget createState() => _WhatIsNewWidget();
}

class _WhatIsNewWidget extends State<WhatIsNewPage> {
  final List<PlatformType> platforms = [PlatformType.Android];

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.whatIsNew)),
      ),
      body: StoreConnector<AppState, WhatIsNewSettingsViewModel>(
        converter: (store) => WhatIsNewSettingsViewModel.fromStore(store),
        builder: (_, viewModel) => WhatIsNewPageComponent(
          getEnv().currentWhatIsNewGuid,
          viewModel.selectedLanguage,
          platforms,
          smallLoadMorePageButton(context),
          (version) async => await getNavigation().navigateAsync(context,
              navigateTo: (context) => WhatIsNewDetailPage(version)),
        ),
      ),
    );
  }
}
