import 'package:flutter/material.dart';

import '../components/adaptive/appBarForSubPage.dart';
import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/button.dart';
import '../components/adaptive/listWithScrollbar.dart';
import '../components/bottomNavbar.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/AppPadding.dart';
import '../constants/ExternalUrls.dart';
import '../constants/Routes.dart';
import '../helpers/analytics.dart';
import '../helpers/deviceHelper.dart';
import '../helpers/external.dart';
import '../helpers/genericHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

class AboutPage extends StatelessWidget {
  AboutPage() {
    trackEvent(AnalyticsEvent.aboutPage);
  }

  @override
  Widget build(BuildContext context) {
    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.about)),
      ),
      body: getBody(context),
      bottomNavigationBar: BottomNavbar(currentRoute: Routes.about),
    );
  }

  Widget getBody(BuildContext context) {
    List<Widget> widgets = List<Widget>();

    widgets.add(emptySpace2x());

    widgets.add(Text(Translations.get(context, LocaleKey.aboutContent),
        textAlign: TextAlign.center,
        maxLines: 50,
        style: TextStyle(fontSize: 16)));

    widgets.add(customDivider());

    widgets.add(genericItemDescription(
      Translations.get(context, LocaleKey.fairUseDisclaimer),
    ));
    
    widgets.add(emptySpace3x());
    widgets.add(positiveButton(
      title: Translations.get(context, LocaleKey.kurtsBlog),
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
