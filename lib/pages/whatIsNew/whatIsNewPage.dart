import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrapmechanic_kurtlourens_com/constants/UIConstants.dart';
import 'package:scrapmechanic_kurtlourens_com/services/json/backupJsonService.dart';

import '../../components/adaptive/appBarForSubPage.dart';
import '../../components/adaptive/appScaffold.dart';
import '../../components/adaptive/paginationControl.dart';
import '../../components/lazyLoadedSearchableList.dart';
import '../../components/tilePresenters/versionTilePresenter.dart';
import '../../constants/AnalyticsEvent.dart';
import '../../contracts/enum/platformType.dart';
import '../../contracts/generated/AssistantApps/versionViewModel.dart';
import '../../helpers/analytics.dart';
import '../../integration/dependencyInjection.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import '../../state/modules/base/appState.dart';
import '../../state/modules/setting/whatIsNewSettingsViewModel.dart';

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
    var currentWhatIsNewGuid = getEnv().currentWhatIsNewGuid;
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.whatIsNew)),
      ),
      body: StoreConnector<AppState, WhatIsNewSettingsViewModel>(
        converter: (store) => WhatIsNewSettingsViewModel.fromStore(store),
        builder: (_, viewModel) => LazyLoadSearchableList<VersionViewModel>(
          (int page) => getVersionApiRepo().getHistory(
            viewModel.selectedLanguage,
            platforms,
            page: page,
          ),
          UIConstants.VersionPageSize,
          versionTilePresenter(context, currentWhatIsNewGuid),
          backupListGetter: (int page) => BackupJsonService().getVersions(
            context,
            langCode: viewModel.selectedLanguage,
            page: page,
            pageSize: UIConstants.VersionPageSize,
          ),
          loadMoreItemWidget: smallLoadMorePageButton(context),
        ),
      ),
    );
  }
}
