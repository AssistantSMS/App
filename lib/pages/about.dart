import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../components/bottomNavbar.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppPadding.dart';
import '../constants/Routes.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key) {
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
      bottomNavigationBar: const BottomNavbar(currentRoute: Routes.about),
    );
  }

  Widget getBody(BuildContext context) {
    List<Widget> widgets = List.empty(growable: true);

    widgets.add(const EmptySpace2x());

    widgets.add(Text(
      getTranslations().fromKey(LocaleKey.aboutContent),
      textAlign: TextAlign.center,
      maxLines: 50,
      style: const TextStyle(fontSize: 16),
    ));

    widgets.add(customDivider());

    widgets.add(GenericItemDescription(
      getTranslations().fromKey(LocaleKey.fairUseDisclaimer),
    ));

    widgets.add(const EmptySpace3x());
    widgets.add(PositiveButton(
      title: getTranslations().fromKey(LocaleKey.kurtsBlog),
      eventString: AnalyticsEvent.externalLinkPersonalBlog,
      onTap: () => launchExternalURL(ExternalUrls.personalBlog),
    ));
    widgets.add(PositiveButton(
      title: "Kurt Lourens",
      eventString: AnalyticsEvent.externalLinkCVWebsite,
      onTap: () => launchExternalURL(ExternalUrls.cvWebsite),
    ));

    widgets.add(const EmptySpace3x());

    return listWithScrollbar(
        padding: AppPadding.listSidePadding,
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index]);
  }
}
