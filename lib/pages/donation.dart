import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants/AnalyticsEvent.dart';
import '../helpers/deviceHelper.dart';
import '../helpers/genericHelper.dart';

class DonationPage extends StatelessWidget {
  DonationPage() {
    getAnalytics().trackEvent(AnalyticsEvent.donationPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(Container(
      key: Key('donationDescrip'),
      child: Text(
        getTranslations().fromKey(LocaleKey.donationDescrip),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      margin: const EdgeInsets.all(4.0),
    ));
    items.add(customDivider());

    List<Widget> paymentOptions = List<Widget>();

    paymentOptions.add(ListTile(
      key: Key('buyMeACoffee'),
      leading: getListTileImage(context, 'donation/buyMeACoffee.png'),
      title: Text(getTranslations().fromKey(LocaleKey.buyMeACoffee),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkBuyMeACoffee);
        launchExternalURL(ExternalUrls.buyMeACoffee);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('patreon'),
      leading: getListTileImage(context, 'donation/patreon.png'),
      title: Text(getTranslations().fromKey(LocaleKey.patreon),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkPatreon);
        launchExternalURL(ExternalUrls.patreon);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('payPal'),
      leading: getListTileImage(context, 'donation/payPal.png'),
      title: Text(getTranslations().fromKey(LocaleKey.paypal),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkPayPal);
        launchExternalURL(ExternalUrls.payPal);
      },
    ));
    paymentOptions.add(ListTile(
      key: Key('openCollective'),
      leading: getListTileImage(context, 'donation/openCollective.png'),
      title: Text(getTranslations().fromKey(LocaleKey.openCollective),
          style: TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkOpenCollective);
        launchExternalURL(ExternalUrls.openCollective);
      },
    ));

    if (paymentOptions.length > 0) {
      items.addAll(paymentOptions);
    } else {
      items.add(ListTile(
        key: Key(LocaleKey.noItems.toString()),
        title: Text(getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
      ));
    }

    return getBaseWidget().appScaffold(
      context,
      appBar: getBaseWidget().appBarForSubPage(
        context,
        showHomeAction: true,
        title: Text(getTranslations().fromKey(LocaleKey.donation)),
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
