import 'package:flutter/material.dart';

import '../../contracts/generated/SteamNewsItem.dart';
import '../../helpers/dateHelper.dart';
import '../common/image.dart';

Widget steamNewsItemTilePresenter(
        BuildContext context, SteamNewsItem news, int index) =>
    GestureDetector(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            news.image == null
                ? localImage('assets/images/defaultGuide.png',
                    boxfit: BoxFit.fill)
                : networkImage(news.image, boxfit: BoxFit.fill),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        overflow: TextOverflow.ellipsis,
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
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
      // onTap: () async => await navigateAsync(context,
      //     navigateTo: (context) => GuidesDetailsPage(guideDetails)),
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
