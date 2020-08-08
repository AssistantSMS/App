import 'package:flutter/material.dart';

import '../../constants/ExternalUrls.dart';
import '../../contracts/generated/PatreonViewModel.dart';
import '../../helpers/external.dart';
import 'genericTilePresenter.dart';

Widget patronTilePresenter(
    BuildContext context, PatreonViewModel patron, int index) {
  if (patron.url == ExternalUrls.patreon) {
    var onTap = () => launchExternalURL(patron.url);
    return Card(
      child: genericListTileWithNetworkImage(
        context,
        imageUrl: patron.imageUrl,
        name: patron.name,
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: onTap,
        ),
      ),
    );
  }
  return genericListTileWithNetworkImage(
    context,
    imageUrl: patron.imageUrl,
    name: patron.name,
  );
  // var userInfoNameAndImageRow = Padding(
  //   padding: EdgeInsets.all(8),
  //   child: Row(
  //     mainAxisSize: MainAxisSize.max,
  //     children: (patron.name != null && patron.name.length > 1)
  //         ? [
  //             ClipOval(
  //               child: networkImage(patron.imageUrl, height: 50, width: 50),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.only(left: 8),
  //               child: Text(
  //                 patron.name,
  //                 maxLines: 1,
  //                 textAlign: TextAlign.left,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //             ),
  //           ]
  //         : [],
  //   ),
  // );
  // return GestureDetector(
  //   child: Card(
  //     semanticContainer: true,
  //     clipBehavior: Clip.antiAliasWithSaveLayer,
  //     child: Column(children: [userInfoNameAndImageRow]),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10.0),
  //     ),
  //     elevation: 5,
  //     margin: EdgeInsets.all(4),
  //   ),
  // );
}
