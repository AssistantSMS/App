import 'package:flutter/material.dart';

import '../../contracts/generated/AssistantApps/contributorViewModel.dart';
import '../../helpers/external.dart';
import 'genericTilePresenter.dart';

Widget contributorTilePresenter(
    BuildContext context, ContributorViewModel contributor, int index) {
  var onTap = () => launchExternalURL(contributor.link);
  return genericListTileWithNetworkImage(
    context,
    name: contributor.name,
    imageUrl: contributor.imageUrl,
    subtitle: Text(contributor.description),
    onTap: onTap,
    trailing: IconButton(icon: Icon(Icons.exit_to_app), onPressed: onTap),
  );
}
