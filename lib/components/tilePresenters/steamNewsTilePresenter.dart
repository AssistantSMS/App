import 'package:flutter/material.dart';

import '../../constants/AppImage.dart';
import '../../contracts/generated/SteamNewsItem.dart';
import '../../helpers/colourHelper.dart';
import '../../helpers/dateHelper.dart';
import '../../helpers/external.dart';
import '../../components/webSpecific/mousePointer.dart';
import '../common/image.dart';

Widget steamNewsItemTilePresenter(
        BuildContext context, SteamNewsItem news, int index) =>
    GestureDetector(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            (news.image == null || news.image.length < 5)
                ? localImage(AppImage.steamNewsDefault, boxfit: BoxFit.fitWidth)
                : networkImage(news.image, boxfit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 7,
                              child: Text(
                                news.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Container(width: 0, height: 0),
                            )
                          ],
                        ),
                      ),
                      Text(
                        news.shortDescription,
                        maxLines: 3,
                        style: TextStyle(color: getCardTextColour(context)),
                      ),
                    ],
                  ),
                  Positioned(
                    child: Text(
                      getDateTimeString(news.date),
                      textAlign: TextAlign.end,
                    ),
                    top: 4,
                    right: 0,
                  )
                ],
              ),
            ),
          ],
        ).showPointerOnHover,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
      onTap: () => launchExternalURL(news.link),
    );

// Widget compactSteamNewsItemTilePresenter(
//     BuildContext context, SteamNewsItem news) {
//   String subTitle = (guideDetails.author ?? '???');
//   if (guideDetails.minutes > 0) {
//     subTitle += ' - ' +
//         Translations.get(context, LocaleKey.minutes)
//             .replaceAll('{0}', guideDetails.minutes.toString());
//   }
//   if (guideDetails.tags.length > 0) {
//     subTitle += ' - ' + guideDetails.tags[0];
//     for (var tagIndex = 1; tagIndex < guideDetails.tags.length; tagIndex++) {
//       subTitle += ', ' + guideDetails.tags[tagIndex];
//     }
//   }
//   return Card(
//     child: genericListTileWithSubtitle(
//       context,
//       leadingImage: null,
//       name: guideDetails.title,
//       subtitle: Text(subTitle, maxLines: 1),
//       // onTap: () async => await navigateAsync(context,
//       //     navigateTo: (context) => GuidesDetailsPage(guideDetails)),
//     ),
//     margin: const EdgeInsets.all(0.0),
//   );
// }
