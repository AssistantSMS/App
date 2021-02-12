import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/bottomNavbar.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppPadding.dart';
import '../constants/Routes.dart';

class AboutPage extends StatelessWidget {
  AboutPage() {
    getAnalytics().trackEvent(AnalyticsEvent.aboutPage);
  }

  @override
  Widget build(BuildContext context) {
    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.about)),
      ),
      body: getBody(context),
      bottomNavigationBar: BottomNavbar(currentRoute: Routes.about),
    );
  }

  Widget getBody(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(emptySpace2x());

    widgets.add(Text(getTranslations().fromKey(LocaleKey.aboutContent),
        textAlign: TextAlign.center,
        maxLines: 50,
        style: TextStyle(fontSize: 16)));

    widgets.add(customDivider());

    widgets.add(genericItemDescription(
      getTranslations().fromKey(LocaleKey.fairUseDisclaimer),
    ));

    widgets.add(emptySpace3x());
    widgets.add(positiveButton(
      title: getTranslations().fromKey(LocaleKey.kurtsBlog),
      eventString: AnalyticsEvent.externalLinkPersonalBlog,
      onPress: () => launchExternalURL(ExternalUrls.personalBlog),
    ));
    widgets.add(positiveButton(
      title: "Kurt Lourens",
      eventString: AnalyticsEvent.externalLinkCVWebsite,
      onPress: () => launchExternalURL(ExternalUrls.cvWebsite),
    ));

    widgets.add(emptySpace3x());

    return listWithScrollbar(
        padding: AppPadding.listSidePadding,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
