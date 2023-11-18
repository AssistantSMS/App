import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../constants/AnalyticsEvent.dart';

class DonationPage extends StatelessWidget {
  DonationPage({Key? key}) : super(key: key) {
    getAnalytics().trackEvent(AnalyticsEvent.donationPage);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.empty(growable: true);
    items.add(Container(
      key: const Key('donationDescrip'),
      child: Text(
        getTranslations().fromKey(LocaleKey.donationDescrip),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      ),
      margin: const EdgeInsets.all(4.0),
    ));
    items.add(customDivider());

    List<Widget> paymentOptions = List.empty(growable: true);

    paymentOptions.add(ListTile(
      key: const Key('buyMeACoffee'),
      leading: const ListTileImage(partialPath: 'donation/buyMeACoffee.png'),
      title: Text(getTranslations().fromKey(LocaleKey.buyMeACoffee),
          style: const TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkBuyMeACoffee);
        launchExternalURL(ExternalUrls.buyMeACoffee);
      },
    ));
    paymentOptions.add(ListTile(
      key: const Key('patreon'),
      leading: const ListTileImage(partialPath: 'donation/patreon.png'),
      title: Text(getTranslations().fromKey(LocaleKey.patreon),
          style: const TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkPatreon);
        launchExternalURL(ExternalUrls.patreon);
      },
    ));
    paymentOptions.add(ListTile(
      key: const Key('payPal'),
      leading: const ListTileImage(partialPath: 'donation/payPal.png'),
      title: Text(getTranslations().fromKey(LocaleKey.paypal),
          style: const TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkPayPal);
        launchExternalURL(ExternalUrls.payPal);
      },
    ));
    paymentOptions.add(ListTile(
      key: const Key('openCollective'),
      leading: const ListTileImage(partialPath: 'donation/openCollective.png'),
      title: Text(getTranslations().fromKey(LocaleKey.openCollective),
          style: const TextStyle(fontSize: 20)),
      onTap: () {
        getAnalytics().trackEvent(AnalyticsEvent.externalLinkOpenCollective);
        launchExternalURL(ExternalUrls.openCollective);
      },
    ));

    if (paymentOptions.isNotEmpty) {
      items.addAll(paymentOptions);
    } else {
      items.add(ListTile(
        key: Key(LocaleKey.noItems.toString()),
        title: Text(getTranslations().fromKey(LocaleKey.noItems),
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 20)),
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
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) => items[index],
      ),
    );
  }
}
