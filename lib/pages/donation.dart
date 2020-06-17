import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/adaptive/appBarForSubPage.dart';
import '../components/adaptive/appScaffold.dart';
import '../components/adaptive/listWithScrollbar.dart';
import '../constants/AnalyticsEvent.dart';
import '../constants/ExternalUrls.dart';
import '../helpers/analytics.dart';
import '../helpers/external.dart';
import '../helpers/genericHelper.dart';
import '../localization/localeKey.dart';
import '../localization/translations.dart';

class DonationPage extends StatelessWidget {
  DonationPage() {
    trackEvent(AnalyticsEvent.donationPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(Container(
      key: Key('donationDescrip'),
      child: Text(
        Translations.get(context, LocaleKey.donationDescrip),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 50,
        style: TextStyle(fontSize: 16),
      ),
      margin: const EdgeInsets.all(4.0),
    ));
    items.add(Divider(key: Key('donationDescripDivider')));

    List<Widget> paymentOptions = List<Widget>();

    paymentOptions.add(ListTile(
      key: Key('buyMeACoffee'),
      leading: getListTileImage(context, 'donation/buyMeACoffee.png'),
      title: Text(Translations.get(context, LocaleKey.buyMeACoffee),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        trackEvent(AnalyticsEvent.externalLinkBuyMeACoffee);
        launchExternalURL(ExternalUrls.buyMeACoffee);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('patreon'),
      leading: getListTileImage(context, 'donation/patreon.png'),
      title: Text(Translations.get(context, LocaleKey.patreon),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        trackEvent(AnalyticsEvent.externalLinkPatreon);
        launchExternalURL(ExternalUrls.patreon);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('payPal'),
      leading: getListTileImage(context, 'donation/payPal.png'),
      title: Text(Translations.get(context, LocaleKey.paypal),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        trackEvent(AnalyticsEvent.externalLinkPayPal);
        launchExternalURL(ExternalUrls.payPal);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('openCollective'),
      leading: getListTileImage(context, 'donation/openCollective.png'),
      title: Text(Translations.get(context, LocaleKey.openCollective),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        trackEvent(AnalyticsEvent.externalLinkOpenCollective);
        launchExternalURL(ExternalUrls.openCollective);
      },
    ));

    if (paymentOptions.length > 0) {
      items.addAll(paymentOptions);
    } else {
      items.add(ListTile(
        key: Key(LocaleKey.noItems.toString()),
        title: Text(Translations.get(context, LocaleKey.noItems),
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
      ));
    }

    return appScaffold(
      context,
      appBar: appBarForSubPageHelper(
        context,
        showHomeAction: true,
        title: Text(Translations.get(context, LocaleKey.donation)),
      ),
      body: listWithScrollbar(
        shrinkWrap: true,
        itemCount: items.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}
