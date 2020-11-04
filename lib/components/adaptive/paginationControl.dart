import 'package:flutter/material.dart';

import '../../helpers/genericHelper.dart';
import '../../localization/localeKey.dart';
import '../../localization/translations.dart';
import 'button.dart';

Widget paginationControl(
        int currentPage, int totalPages, Function next, Function prev) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (currentPage > 1) ...[
          Center(child: positiveButton(title: '<', onPress: prev))
        ],
        if (currentPage < totalPages) ...[
          Center(child: positiveButton(title: '>', onPress: next))
        ],
      ],
    );

Widget smallLoadMorePageButton(BuildContext context) => smallPageButton(context,
    Translations.get(context, LocaleKey.loadMore), Icons.navigate_next);

Widget smallPageButton(BuildContext context, String title, IconData icon) {
  return ListTile(
    leading: getCorrectlySizedImageFromIcon(context, icon),
    title: Text(title),
  );
}

// Widget largeNextPageButton(BuildContext context) => largePageButton(
//     Translations.get(context, LocaleKey.next), Icons.navigate_next);
// Widget largePrevPageButton(BuildContext context) => largePageButton(
//     Translations.get(context, LocaleKey.previous), Icons.navigate_before);

// Widget largePageButton(String title, IconData icon) {
//   double height = 180;
//   return commonCard(
//     Container(
//       height: height,
//       width: double.infinity,
//       child: Center(child: Icon(icon, size: height)),
//     ),
//     Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(bottom: 8.0),
//           child: Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//       ],
//     ),
//   );
// }
